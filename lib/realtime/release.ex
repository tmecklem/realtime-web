defmodule Realtime.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  # @app :realtime

  def migrate do
  end

  def rollback(_repo, _version) do
  end
end
