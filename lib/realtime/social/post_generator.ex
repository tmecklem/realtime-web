defmodule Realtime.Social.PostGenerator do
  use GenServer

  alias Realtime.Social.CoordinateGenerator
  alias Realtime.Social.Post
  alias Realtime.Social.PostEvents
  alias Faker.Internet
  alias Faker.Lorem.Shakespeare

  @default_rate 3
  @wait_times [5000, 4000, 3000, 2000, 1000, 750, 500, 400, 300, 200, 10]

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    :timer.send_after(Enum.at(@wait_times, @default_rate), :post)
    {:ok, %{rate: @default_rate, posts: []}}
  end

  def list_posts, do: GenServer.call(__MODULE__, :list_posts)

  def change_rate(new_rate) when new_rate <= 11 and new_rate >= 0 do
    GenServer.call(__MODULE__, {:change_rate, new_rate})
  end

  def get_rate, do: GenServer.call(__MODULE__, :get_rate)

  @impl GenServer
  def handle_call(:list_posts, _sender, %{posts: posts} = state) do
    {:reply, posts, state}
  end

  @impl GenServer
  def handle_call({:change_rate, new_rate}, _sender, state) do
    PostEvents.notify(:rate_changed, new_rate)
    {:reply, :ok, %{state | rate: new_rate}}
  end

  @impl GenServer
  def handle_call(:get_rate, _sender, %{rate: rate} = state) do
    {:reply, rate, state}
  end

  @impl GenServer
  def handle_info(:post, %{rate: rate, posts: posts} = state) do
    post =
      Post.new(%{
        content: get_random_content(),
        location: get_random_location(),
        author: Internet.user_name(),
        relevance: Enum.random(40..100),
        timestamp: DateTime.now!("America/New_York")
      })

    PostEvents.notify(:post_created, post)
    :timer.send_after(random_interval(rate), :post)

    {:noreply, %{state | posts: Enum.take([post | posts], 100)}}
  end

  defp random_interval(rate) do
    wait_time = Enum.at(@wait_times, rate - 1)
    wait_time + max(trunc(wait_time * (Enum.random(-100..200) / 100.0)), 0)
  end

  defp get_random_content do
    [:as_you_like_it, :hamlet, :king_richard_iii, :romeo_and_juliet]
    |> Enum.random()
    |> then(&apply(Shakespeare, &1, []))
  end

  defp get_random_location do
    CoordinateGenerator.random_location()
  end
end
