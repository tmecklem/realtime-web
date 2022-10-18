defmodule RealtimeWeb.InventoryLive.Show do
  use RealtimeWeb, :live_view

  alias Realtime.Commerce
  alias Realtime.Commerce.Product
  alias Realtime.Commerce.InventoryEvents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    Stock Level: <%= @product.stock_level %>
    <button phx-click="decrement">-</button>
    <button phx-click="increment">+</button>
    """
  end

  @impl true
  def handle_params(%{"id" => sku}, _, socket) do
    product = Commerce.get_product!(sku)

    if connected?(socket), do: InventoryEvents.listen_for_events(product)

    {
      :noreply,
      socket
      |> assign(:product, product)
    }
  end

  @impl true
  def handle_event("increment", _value, socket) do
    {:ok, product} = Commerce.increment_inventory(socket.assigns.product)

    {:noreply, assign(socket, product: product)}
  end

  @impl true
  def handle_event("decrement", _value, socket) do
    {:ok, product} = Commerce.decrement_inventory(socket.assigns.product)

    {:noreply, assign(socket, product: product)}
  end

  @impl true
  def handle_info({:inventory_changed, %Product{sku: sku} = product}, socket) do
    if socket.assigns.product.sku == sku do
      {:noreply, socket |> assign(product: product)}
    else
      {:noreply, socket}
    end
  end
end
