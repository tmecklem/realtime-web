defmodule Realtime.Commerce.Cart do
  use GenServer

  alias Realtime.Commerce.Product
  alias Realtime.Commerce.User

  def start_link(opts) do
    name =
      opts
      |> Keyword.fetch!(:user)
      |> Map.get(:id)
      |> via_tuple()

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def init(opts) do
    user_id =
      opts
      |> Keyword.fetch!(:user)
      |> Map.get(:id)

    {:ok, %{user_id: user_id, items: []}}
  end

  def add_to_cart(%User{} = user, %Product{} = product),
    do: GenServer.call(cart_process(user), {:add_to_cart, product})

  def get_items(%User{} = user), do: GenServer.call(cart_process(user), :get_items)

  @impl GenServer
  def handle_call({:add_to_cart, %Product{} = product}, _from, %{items: items} = state) do
    {:reply, :ok, %{state | items: items ++ [product]}}
  end

  @impl GenServer
  def handle_call(:get_items, _from, %{items: items} = state) do
    {:reply, items, state}
  end

  defp cart_process(user) do
    case Registry.lookup(Registry.CartRegistry, user.id) do
      [] ->
        {:ok, pid} = __MODULE__.start_link(user: user)
        pid

      [{pid, _} | _] ->
        pid
    end
  end

  defp via_tuple(user_id) do
    {:via, Registry, {Registry.CartRegistry, user_id}}
  end
end
