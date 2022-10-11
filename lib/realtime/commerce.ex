defmodule Realtime.Commerce do
  @moduledoc """
  The Commerce context.
  """

  alias Realtime.Commerce.ProductInventory

  @doc """
  Gets a single product.

  ## Examples

      iex> get_product!(123)
      %Product{}

  """
  def get_product!(sku) do
    sku
    |> ProductInventory.product()
    |> case do
      {:ok, product} -> product
    end
  end
end
