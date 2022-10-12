defmodule Realtime.Commerce.ProductInventory do
  use GenServer

  alias Realtime.Commerce.Product

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
        %{product: %Product{stock_level: stock_level} = product} = state
      ) do
    if stock_level > 0 do
      {:reply, true, %{product: %{product | stock_level: stock_level - 1}}}
    else
      {:reply, false, state}
    end
  end

  defp via_tuple(sku) do
    {:via, Registry, {Registry.ProductStockRegistry, sku}}
  end
end
