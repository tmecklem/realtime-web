defmodule RealtimeWeb.CartLive.Show do
  use RealtimeWeb, :live_view
  use Timex

  alias Realtime.Commerce
  alias Realtime.Commerce.User
  alias Realtime.Commerce.CartEvents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(
        %{"user_id" => user_id, "user_name" => user_name, "back_link" => back_link},
        _,
        socket
      ) do
    user = User.new(%{id: user_id, name: user_name})

    if connected?(socket), do: CartEvents.listen_for_events(user)

    {:noreply,
     socket
     |> assign(:user, user)
     |> assign(:countdown_time, nil)
     |> assign(:items, Commerce.get_items(user))
     |> assign(:back_link, back_link)}
  end

  @impl true
  def handle_event("remove_from_cart", %{"sku" => sku}, socket) do
    items = Commerce.remove_exclusive_from_cart(socket.assigns.user, Commerce.get_product!(sku))
    {:noreply, assign(socket, items: items)}
  end

  @impl true
  def handle_event("checkout", _value, socket) do

    # TODO handle an already claimed item at checkout

    case Commerce.checkout(socket.assigns.user, socket.assigns.items) do
      :ok ->
        {:noreply,
         socket
         |> push_navigate(
           to:
             Routes.checkout_show_path(socket, :show,
               user_id: socket.assigns.user.id,
               user_name: socket.assigns.user.name
             )
         )}

      {:error, message} ->
        {:noreply, put_flash(socket, :error, message)}
    end
  end

  @impl true
  def handle_info(
        {:countdown_seconds, seconds_left},
        state
      ) do
    {:noreply, assign(state, countdown_time: humanized_time_left(seconds_left))}
  end

  defp humanized_time_left(nil), do: nil
  defp humanized_time_left(seconds) when seconds < 1, do: nil

  defp humanized_time_left(seconds) do
    seconds
    |> Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end
end
