defmodule Realtime.Social.PostEvents do
  def listen_for_events(event_type) when event_type in [:post_created, :rate_changed] do
    Registry.register(__MODULE__, event_type, [])
  end

  def notify(event_type, arguments) do
    Registry.dispatch(__MODULE__, event_type, fn entries ->
      for {pid, _} <- entries, do: send(pid, {event_type, arguments})
    end)
  end
end
