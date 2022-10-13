defmodule Realtime.Commerce.InventoryEvents do
  alias Realtime.Commerce.Product

  def listen_for_events(%Product{sku: sku}) do
    Registry.register(
      __MODULE__,
      sku,
      []
    )
  end

  def notify(sku, event_name, arguments) do
    Registry.dispatch(__MODULE__, sku, fn entries ->
      for {pid, _} <- entries, do: send(pid, {event_name, arguments})
    end)
  end
end
