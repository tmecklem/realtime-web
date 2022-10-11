defmodule RealtimeWeb.CartLive.Show do
  use RealtimeWeb, :live_view

  alias Realtime.Commerce
  alias Realtime.Commerce.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"user_id" => user_id, "user_name" => user_name} = params, _, socket) do
    user = %User{id: user_id, name: user_name}

    {:noreply,
     socket
     |> assign(:user, user)
     |> assign(:items, Commerce.get_items(user))}
  end
end
