defmodule Realtime.Commerce.User do
  use TypedStruct

  typedstruct do
    @typedoc "A user of the commerce context"
    field :name, String.t(), enforce: true
    field :id, integer(), enforce: true
  end
end
