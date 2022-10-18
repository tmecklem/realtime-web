defmodule Realtime.Commerce.ProductInventory do
  use GenServer

  alias Realtime.Commerce.Product
  alias Realtime.Commerce.InventoryEvents

  def start_link(opts) do
    product = %Product{} = Keyword.fetch!(opts, :product)
    name = via_tuple(product.sku)

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @impl GenServer
  def init(opts) do
    product = Keyword.fetch!(opts, :product)

    {:ok, %{product: product}}
  end

  def product(sku), do: GenServer.call(via_tuple(sku), :product)
  def stock_level(sku), do: GenServer.call(via_tuple(sku), :stock_level)
  def claim_product(sku), do: GenServer.call(via_tuple(sku), :claim_product)
  def unclaim_product(sku), do: GenServer.call(via_tuple(sku), :unclaim_product)
  def increment(sku), do: GenServer.call(via_tuple(sku), :increment)
  def decrement(sku), do: GenServer.call(via_tuple(sku), :decrement)

  @impl GenServer
  def handle_call(:product, _from, %{product: %Product{} = product} = state) do
    {:reply, {:ok, product}, state}
  end

  @impl GenServer
  def handle_call(:stock_level, _from, %{product: %Product{stock_level: stock_level}} = state) do
    {:reply, {:ok, stock_level}, state}
  end

  @impl GenServer
  def handle_call(
        :claim_product,
        _from,
        %{product: %Product{sku: sku, stock_level: stock_level} = product} = state
      ) do
    if stock_level > 0 do
      updated_product = %{product | stock_level: stock_level - 1}

      InventoryEvents.notify(sku, :inventory_changed, updated_product)

      {:reply, true, %{product: updated_product}}
    else
      {:reply, false, state}
    end
  end

  @impl GenServer
  def handle_call(
        :unclaim_product,
        _from,
        %{product: %Product{sku: sku, stock_level: stock_level} = product} = state
      ) do
    updated_product = %{product | stock_level: stock_level + 1}

    InventoryEvents.notify(sku, :inventory_changed, updated_product)

    {:reply, true, %{state | product: updated_product}}
  end

  @impl GenServer
  def handle_call(:increment, _from, %{product: %Product{sku: sku, stock_level: stock_level} = product} = state) do
    updated_product = %{product | stock_level: stock_level + 1}

    InventoryEvents.notify(sku, :inventory_changed, updated_product)

    {:reply, {:ok, updated_product}, %{state | product: updated_product}}
  end

  @impl GenServer
  def handle_call(:decrement, _from, %{product: %Product{sku: sku, stock_level: stock_level} = product} = state) do
    updated_product = %{product | stock_level: max(stock_level - 1, 0)}

    InventoryEvents.notify(sku, :inventory_changed, updated_product)

    {:reply, {:ok, updated_product}, %{state | product: updated_product}}
  end

  defp via_tuple(sku) do
    {:via, Registry, {Registry.ProductStockRegistry, sku}}
  end
end
