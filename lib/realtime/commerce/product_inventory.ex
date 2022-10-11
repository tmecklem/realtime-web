defmodule Realtime.Commerce.ProductInventory do
  use GenServer

  alias Realtime.Commerce.Product

  def start_link(opts) do
    name =
      opts
      |> Keyword.fetch!(:product)
      |> Map.get(:sku)
      |> via_tuple()

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @impl GenServer
  def init(opts) do
    product = Keyword.fetch!(opts, :product)

    {:ok, %{product: product}}
  end

  def product(sku), do: GenServer.call(via_tuple(sku), :product)
  def stock_level(sku), do: GenServer.call(via_tuple(sku), :stock_level)

  @impl GenServer
  def handle_call(:product, _from, %{product: %Product{} = product} = state) do
    {:reply, {:ok, product}, state}
  end

  @impl GenServer
  def handle_call(:stock_level, _from, %{product: %Product{stock_level: stock_level}} = state) do
    {:reply, {:ok, stock_level}, state}
  end

  defp via_tuple(sku) do
    {:via, Registry, {Registry.ProductStockRegistry, sku}}
  end
end
