defmodule Realtime.Commerce.CartEvents do
  alias Realtime.Commerce.User

  def listen_for_events(%User{id: id}) do
    Registry.register(
      __MODULE__,
      id,
      []
    )
  end

  def notify(user_id, event_name, arguments) do
    Registry.dispatch(__MODULE__, user_id, fn entries ->
      for {pid, _} <- entries, do: send(pid, {event_name, arguments})
    end)
  end
end
