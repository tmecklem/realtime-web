defmodule Realtime.Social do
  @moduledoc """
  The Social context.
  """

  alias Realtime.Social.PostGenerator

  def list_posts do
    PostGenerator.list_posts()
  end
end
