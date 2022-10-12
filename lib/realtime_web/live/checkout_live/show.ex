defmodule RealtimeWeb.CheckoutLive.Show do
  use RealtimeWeb, :live_view

  alias Realtime.Commerce.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"user_id" => user_id, "user_name" => user_name}, _, socket) do
    user = User.new(%{id: user_id, name: user_name})
    {:noreply, assign(socket, user: user)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    Thank you for your business, <%=@user.name%>!


    <%= live_patch "Shop more", to: Routes.product_show_path(@socket, :show, "scarce-scarf", user_id: @user.id, user_name: @user.name) %>
    """
  end
end
