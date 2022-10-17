defmodule Realtime.BetterCommerce do
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

  def remove_exclusive_from_cart(user, product) do
    with :ok = Cart.remove_from_cart(user, product),
         true <- ProductInventory.unclaim_product(product.sku),
         :ok <- Cart.stop_checkout_timer(user) do
      Cart.get_items(user)
    else
      _ -> {:error, "Unable to remove from cart"}
    end
  end

  def exclusive_add_to_cart(user, product) do
    with :ok <- Cart.add_to_cart(user, product),
         true <- ProductInventory.claim_product(product.sku),
         :ok <- Cart.start_checkout_timer(user, 480) do
      :ok
    else
      _ -> {:error, "Unable to add to cart"}
    end
  end

  def get_items(user) do
    Cart.get_items(user)
  end

  def product_in_cart?(user, sku) do
    user
    |> Cart.get_items()
    |> Enum.any?(fn product -> product.sku == sku end)
  end

  def checkout(user, _products) do
    Cart.clear_cart(user)
  end
end
