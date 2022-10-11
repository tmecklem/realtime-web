defmodule Realtime.Commerce.Product do
  use TypedStruct

  typedstruct do
    @typedoc "A product that can be listed"
    field :name, String.t(), enforce: true
    field :sku, String.t(), enforce: true
    field :stock_level, integer(), enforce: true
  end
end
