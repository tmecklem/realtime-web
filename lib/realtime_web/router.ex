defmodule RealtimeWeb.Router do
  use RealtimeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RealtimeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/commerce", RealtimeWeb do
    pipe_through :browser

    live "/products/:id", ProductLive.Show, :show
    live "/cart", CartLive.Show, :show
  end

  scope "/", RealtimeWeb do
    pipe_through :browser

    get "/", Plug.Redirect, to: "/slides/index.html"
  end
end
