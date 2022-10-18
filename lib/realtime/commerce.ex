defmodule Realtime.Commerce do
  @moduledoc """
  The Commerce context.
  """

  alias Realtime.Commerce.ProductInventory
  alias Realtime.Commerce.Cart
  alias Realtime.Commerce.Product

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

  def remove_from_cart(user, product) do
    :ok = Cart.remove_from_cart(user, product)
    Cart.get_items(user)
  end

  def add_to_cart(user, product) do
    Cart.add_to_cart(user, product)
  end

  def get_items(user) do
    Cart.get_items(user)
  end

  def product_in_cart?(user, sku) do
    user
    |> Cart.get_items()
    |> Enum.any?(fn product -> product.sku == sku end)
  end

  def checkout(user, products) do
    if Enum.all?(products, fn product -> ProductInventory.claim_product(product.sku) end) do
      Cart.clear_cart(user)
    else
      {:error, "Oh no! We're out of product and can't complete your order!"}
    end
  end

  def increment_inventory(product = %Product{}) do
    ProductInventory.increment(product.sku)
  end

  def decrement_inventory(product = %Product{}) do
    ProductInventory.decrement(product.sku)
  end
end
