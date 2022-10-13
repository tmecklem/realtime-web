defmodule Realtime.Commerce.Cart do
  use GenServer

  alias Realtime.Commerce.CartEvents
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

  def start_checkout_timer(%User{} = user, countdown_seconds),
    do: GenServer.call(cart_process(user), {:start_checkout_timer, countdown_seconds})

  def stop_checkout_timer(%User{} = user),
    do: GenServer.call(cart_process(user), :stop_checkout_timer)

  @impl GenServer
  def handle_call({:add_to_cart, %Product{} = product}, _from, %{items: items} = state) do
    {:reply, :ok, %{state | items: items ++ [product]}}
  end

  @impl GenServer
  def handle_call({:remove_from_cart, %Product{sku: sku}}, _from, %{items: items} = state) do
    updated_items = Enum.reject(items, &(sku == &1.sku))

    {:reply, :ok, %{state | items: updated_items}}
  end

  @impl GenServer
  def handle_call(:clear_cart, _from, state) do
    {:reply, :ok, %{state | items: []}}
  end

  @impl GenServer
  def handle_call(:get_items, _from, %{items: items} = state) do
    {:reply, items, state}
  end

  @impl GenServer
  def handle_call({:start_checkout_timer, countdown_seconds}, _from, state)
      when countdown_seconds > 0 do
    :timer.send_after(1000, :tick)
    {:reply, :ok, Map.put(state, :countdown_seconds, countdown_seconds)}
  end

  @impl GenServer
  def handle_call(:stop_checkout_timer, _from, %{user_id: user_id} = state) do
    CartEvents.notify(user_id, :countdown_seconds, 0)

    {:reply, :ok, Map.put(state, :countdown_seconds, 0)}
  end

  @impl GenServer
  def handle_info(:tick, %{countdown_seconds: countdown_seconds} = state)
      when countdown_seconds < 1,
      do: {:noreply, state}

  def handle_info(:tick, %{user_id: user_id, countdown_seconds: countdown_seconds} = state) do
    seconds_left = countdown_seconds - 1

    CartEvents.notify(user_id, :countdown_seconds, seconds_left)
    if seconds_left > 0, do: :timer.send_after(1000, :tick)
    {:noreply, %{state | countdown_seconds: seconds_left}}
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
