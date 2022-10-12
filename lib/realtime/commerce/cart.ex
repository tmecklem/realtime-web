defmodule Realtime.Commerce.Cart do
  use GenServer

  alias Realtime.Commerce.Product
  alias Realtime.Commerce.User

  def start(user) do
    DynamicSupervisor.start_child(Realtime.CartSupervisor, {__MODULE__, [user: user]})
  end

  def start_link(opts) do
    user = %User{} = Keyword.fetch!(opts, :user)
    name = via_tuple(user.id)

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @impl GenServer
  def init(opts) do
    user_id =
      opts
      |> Keyword.fetch!(:user)
      |> Map.get(:id)

    {:ok, %{user_id: user_id, items: []}}
  end

  def add_to_cart(%User{} = user, %Product{} = product),
    do: GenServer.call(cart_process(user), {:add_to_cart, product})

  def remove_from_cart(%User{} = user, sku),
    do: GenServer.call(cart_process(user), {:remove_from_cart, sku})

  def clear_cart(%User{} = user),
    do: GenServer.call(cart_process(user), :clear_cart)

  def get_items(%User{} = user), do: GenServer.call(cart_process(user), :get_items)

  @impl GenServer
  def handle_call({:add_to_cart, %Product{} = product}, _from, %{items: items} = state) do
    {:reply, :ok, %{state | items: items ++ [product]}}
  end

  @impl GenServer
  def handle_call({:remove_from_cart, %Product{} = product}, _from, %{items: items} = state) do
    {:reply, :ok, %{state | items: List.delete(items, product)}}
  end

  @impl GenServer
  def handle_call(:clear_cart, _from, state) do
    {:reply, :ok, %{state | items: []}}
  end

  @impl GenServer
  def handle_call(:get_items, _from, %{items: items} = state) do
    {:reply, items, state}
  end

  defp cart_process(user) do
    with [] <- Registry.lookup(Registry.CartRegistry, "#{user.id}-cart"),
         {:ok, _} <- __MODULE__.start(user),
         [] <- Registry.lookup(Registry.CartRegistry, "#{user.id}-cart") do
      {:error, "Something bad happened trying to get or create the cart for #{user.id}"}
    else
      [{pid, _} | _] -> pid
      error -> error
    end
  end

  defp via_tuple(user_id) do
    {:via, Registry, {Registry.CartRegistry, "#{user_id}-cart"}}
  end
end
