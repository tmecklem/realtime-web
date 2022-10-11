defmodule Realtime.Commerce do
  @moduledoc """
  The Commerce context.
  """

  alias Realtime.Commerce.ProductInventory
  alias Realtime.Commerce.Cart

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

  def add_to_cart(user, product) do
    Cart.add_to_cart(user, product)
  end

  def get_items(user) do
    Cart.get_items(user)
  end
end
