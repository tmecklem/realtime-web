defmodule RealtimeWeb.Plug.Redirect do
  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
  end
end
