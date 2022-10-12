defmodule Realtime.Commerce.User do
  use TypedStruct

  typedstruct do
    @typedoc "A user of the commerce context"
    field :name, String.t(), enforce: true
    field :id, integer(), enforce: true
  end

  def new(attrs) when is_map(attrs) do
    %__MODULE__{
      id: String.to_integer(Map.get(attrs, :id)),
      name: Map.get(attrs, :name)
    }
  end
end
