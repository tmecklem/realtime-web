defmodule RealtimeWeb.PostLive.Index do
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

    {:noreply, socket |> assign(:posts, Social.list_posts())}
  end

  @impl true
  def handle_info({:post_created, %Post{} = post}, socket) do
    {:noreply, socket |> assign(posts: Enum.take([post | socket.assigns.posts], 100))}
  end
end
