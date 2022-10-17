defmodule RealtimeWeb.BetterPostLive.Index do
  use RealtimeWeb, :live_view
  use Timex

  alias Realtime.Social
  alias Realtime.Social.Post
  alias Realtime.Social.PostEvents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _, socket) do
    if connected?(socket), do: PostEvents.listen_for_events(:post_created)

    :timer.send_after(500, :tick)

    {
      :noreply,
      socket
      |> assign(:posts, Social.list_posts())
      |> assign(:queued_posts, [])
      |> assign(:last_refreshed, timestamp())
      |> assign(humanized_last_refreshed: humanized_last_refreshed(timestamp()))
    }
  end

  @impl true
  def handle_event("refresh_posts", _values, socket) do
    new_posts = Enum.take(socket.assigns.queued_posts ++ socket.assigns.posts, 100)

    {
      :noreply,
      socket
      |> assign(posts: new_posts)
      |> assign(queued_posts: [])
      |> assign(last_refreshed: timestamp())
    }
  end

  @impl true
  def handle_info({:post_created, %Post{} = post}, socket) do
    cond do
      length(socket.assigns.queued_posts) > 0 ->
        {
          :noreply,
          socket
          |> assign(queued_posts: [post | socket.assigns.queued_posts])
        }

      Timex.diff(timestamp(), socket.assigns.last_refreshed, :seconds) > 4 ->
        {
          :noreply,
          socket
          |> assign(posts: Enum.take([post | socket.assigns.posts], 100))
          |> assign(last_refreshed: timestamp())
          |> assign(humanized_last_refreshed: humanized_last_refreshed(timestamp()))
        }

      true ->
        {
          :noreply,
          socket
          |> assign(queued_posts: [post | socket.assigns.queued_posts])
        }
    end
  end

  @impl true
  def handle_info(:tick, socket) do
    :timer.send_after(1000, :tick)

    socket =
      cond do
        length(socket.assigns.queued_posts) > 2 ->
          socket

        Timex.diff(timestamp(), socket.assigns.last_refreshed, :seconds) > 4 ->
          new_posts = Enum.take(socket.assigns.queued_posts ++ socket.assigns.posts, 100)

          socket
          |> assign(posts: new_posts)
          |> assign(queued_posts: [])
          |> assign(last_refreshed: timestamp())

        true ->
          socket
      end

    {
      :noreply,
      socket
      |> assign(humanized_last_refreshed: humanized_last_refreshed(socket.assigns.last_refreshed))
    }
  end

  def timestamp do
    DateTime.now!("America/New_York")
  end

  defp humanized_last_refreshed(last_refreshed) do
    timestamp()
    |> Timex.diff(last_refreshed, :seconds)
    |> case do
      time when time < 1 ->
        "0 seconds"

      time ->
        time
        |> Duration.from_seconds()
        |> Timex.format_duration(:humanized)
    end
  end
end
