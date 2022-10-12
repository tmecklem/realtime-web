defmodule RealtimeWeb.ProductLive.Show do
  use RealtimeWeb, :live_view

  alias Realtime.Commerce
  alias Realtime.Commerce.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => sku, "user_id" => user_id, "user_name" => user_name}, _, socket) do
    user = User.new(%{id: user_id, name: user_name})
    product = Commerce.get_product!(sku)

    {:noreply,
     socket
     |> assign(:user, user)
     |> assign(:product, product)
     |> assign(:button_state, button_state(user, product))}
  end

  @impl true
  def handle_event("add_to_cart", _value, socket) do
    case Commerce.add_to_cart(socket.assigns.user, socket.assigns.product) do
      :ok ->
        {:noreply,
         socket
         |> push_navigate(
           to:
             Routes.cart_show_path(socket, :show,
               user_id: socket.assigns.user.id,
               user_name: socket.assigns.user.name
             )
         )}
    end
  end

  defp button_state(user, product) do
    cond do
      Commerce.product_in_cart?(user, product.sku) -> {true, "Already in cart"}
      product.stock_level < 1 -> {true, "Out of stock"}
      true -> {false, "Add to cart"}
    end
  end
end
