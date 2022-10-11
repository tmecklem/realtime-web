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
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, %User{id: user_id, name: user_name})
     |> assign(:product, Commerce.get_product!(sku))}
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

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
