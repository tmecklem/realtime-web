defmodule RealtimeWeb.CartLive.Show do
  use RealtimeWeb, :live_view

  alias Realtime.Commerce
  alias Realtime.Commerce.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"user_id" => user_id, "user_name" => user_name}, _, socket) do
    user = User.new(%{id: user_id, name: user_name})

    {:noreply,
     socket
     |> assign(:user, user)
     |> assign(:items, Commerce.get_items(user))}
  end

  @impl true
  def handle_event("remove_from_cart", %{"sku" => sku}, socket) do
    items = Commerce.remove_from_cart(socket.assigns.user, Commerce.get_product!(sku))
    {:noreply, assign(socket, items: items)}
  end

  @impl true
  def handle_event("checkout", _value, socket) do
    case Commerce.checkout(socket.assigns.user, socket.assigns.items) do
      :ok ->
        {:noreply,
         socket
         |> push_navigate(
           to:
             Routes.checkout_show_path(socket, :show,
               user_id: socket.assigns.user.id,
               user_name: socket.assigns.user.name
             )
         )}

      {:error, message} ->
        {:noreply, put_flash(socket, :error, message)}
    end
  end
end
