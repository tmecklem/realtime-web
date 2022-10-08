defmodule Realtime.TweetGenerator do
  use GenServer

  def init(opts \\ []) do
    messages_per_second = 1_000 / Keyword.get(opts, :messages_per_second, 1)

    :timer.send_after({self()})
    {:ok, messages_per_second: messages_per_second}
  end
end
