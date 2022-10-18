defmodule RealtimeWeb.BetterPostLive.Index do
  use RealtimeWeb, :live_view
  use Timex

  alias Realtime.Social
  alias Realtime.Social.Post
  alias Realtime.Social.PostEvents

  @high_relevancy_threshold 90

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _, socket) do
    if connected?(socket), do: PostEvents.listen_for_events(:post_created)

    posts = Social.list_posts()

    {
      :noreply,
      socket
      |> assign(:posts, posts)
      |> assign(:display_posts, posts)
      |> assign(:queued_posts, [])
      |> assign(:last_refreshed, timestamp())
      |> assign(:high_relevancy, false)
    }
  end

  @impl true
  def handle_event("toggle_relevancy", values, socket) do
    high_relevancy =
      case values do
        %{"value" => "on"} -> true
        _ -> false
      end

    socket = assign(socket, high_relevancy: high_relevancy)
    {:noreply, process_queued_posts(socket)}
  end

  @impl true
  def handle_event("refresh_posts", _values, socket) do
    {:noreply, process_queued_posts(socket)}
  end

  @impl true
  def handle_info({:post_created, %Post{} = post}, socket) do
    if socket.assigns.high_relevancy ||
         (length(socket.assigns.queued_posts) == 0 &&
            Timex.diff(timestamp(), socket.assigns.last_refreshed, :seconds) > 4) do
      new_posts = [post | socket.assigns.posts]

      {
        :noreply,
        socket
        |> assign(posts: new_posts)
        |> assign(display_posts: Enum.take(filter_posts(new_posts, socket.assigns.high_relevancy), 100))
        |> assign(last_refreshed: timestamp())
      }
    else
      {
        :noreply,
        socket
        |> assign(queued_posts: [post | socket.assigns.queued_posts])
      }
    end
  end

  defp process_queued_posts(socket) do
    new_posts = Enum.take(socket.assigns.queued_posts ++ socket.assigns.posts, 100)

    socket
    |> assign(posts: new_posts)
    |> assign(queued_posts: [])
    |> assign(last_refreshed: timestamp())
    |> assign(display_posts: Enum.take(filter_posts(socket.assigns.posts, socket.assigns.high_relevancy), 100))
  end

  defp filter_posts(posts, apply_high_threshold) do
    Enum.filter(posts, &filter_post(&1, if(apply_high_threshold, do: @high_relevancy_threshold, else: 0)))
  end

  defp filter_post(%Post{relevance: relevance}, threshold) when relevance >= threshold, do: true
  defp filter_post(_, _), do: false

  def timestamp do
    DateTime.now!("America/New_York")
  end
end
