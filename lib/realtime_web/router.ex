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
    live "/checkout", CheckoutLive.Show, :show

    live "/better_products/:id", BetterProductLive.Show, :show
    live "/better_cart", BetterCartLive.Show, :show
    live "/better_checkout", BetterCheckoutLive.Show, :show

    live "/inventory/:id", InventoryLive.Show, :show
  end

  scope "/social", RealtimeWeb do
    pipe_through :browser

    live "/posts", PostLive.Index, :index
    live "/better_posts", BetterPostLive.Index, :index

    live "/rate_intensity", RateIntensityLive.Index, :index
  end

  scope "/", RealtimeWeb do
    pipe_through :browser

    get "/", Plug.Redirect, to: "/slides/index.html"
  end
end
