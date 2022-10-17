defmodule Realtime.Social.Post do
  use TypedStruct

  typedstruct do
    @typedoc "A social media post"
    field :content, String.t(), enforce: true
    field :author, User.t(), enforce: true
    field :location, tuple(), enforce: true
    field :relevance, integer(), enforce: true
    field :timestamp, DateTime.t(), enforce: true
  end

  def new(%{} = attrs) do
    %__MODULE__{
      content: attrs.content,
      author: attrs.author,
      location: attrs.location,
      relevance: attrs.relevance,
      timestamp: attrs.timestamp
    }
  end
end
