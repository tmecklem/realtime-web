defmodule Realtime.Social.PostGenerator do
  use GenServer

  alias Realtime.Social.CoordinateGenerator
  alias Realtime.Social.Post
  alias Realtime.Social.PostEvents
  alias Faker.Internet
  alias Faker.Lorem.Shakespeare

  @wait_time 800

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    :timer.send_after(@wait_time, :post)
    {:ok, %{wait_time: @wait_time, posts: []}}
  end

  def list_posts, do: GenServer.call(__MODULE__, :list_posts)

  @impl GenServer
  def handle_call(:list_posts, _sender, %{posts: posts} = state) do
    {:reply, posts, state}
  end

  @impl GenServer
  def handle_info(:post, %{wait_time: wait_time, posts: posts} = state) do
    post =
      Post.new(%{
        content: get_random_content(),
        location: get_random_location(),
        author: Internet.user_name(),
        relevance: Enum.random(40..100),
        timestamp: DateTime.now!("America/New_York")
      })

    PostEvents.notify(:post_created, post)
    :timer.send_after(random_interval(wait_time), :post)

    {:noreply, %{state | posts: Enum.take([post | posts], 100)}}
  end

  defp random_interval(wait_time) do
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
