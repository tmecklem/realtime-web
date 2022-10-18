defmodule RealtimeWeb.RateIntensityLive.Index do
  use RealtimeWeb, :live_view

  alias Realtime.Social.PostGenerator
  alias Realtime.Social.PostEvents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(rate: PostGenerator.get_rate())}
  end

  @impl true
  def handle_params(_params, _, socket) do
    if connected?(socket), do: PostEvents.listen_for_events(:rate_changed)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <form phx-change="change_rate">
      <div class="slider">
        <input type="range" name="rate" min="1" max="11" value={@rate}>
        <p><%= @rate %></p>
      </div>
    </form>
    """
  end

  @impl true
  def handle_event("change_rate", %{"rate" => rate}, socket) do
    rate = String.to_integer(rate)
    PostGenerator.change_rate(rate)

    {:noreply, assign(socket, rate: rate)}
  end

  @impl true
  def handle_info({:rate_changed, new_rate}, socket) do
    {:noreply, assign(socket, rate: new_rate)}
  end
end
