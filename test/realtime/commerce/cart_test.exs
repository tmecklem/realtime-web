defmodule Realtime.Commerce.CartTest do
  use ExUnit.Case

  alias Realtime.Commerce.Cart
  alias Realtime.Commerce.Product
  alias Realtime.Commerce.User

  describe "adding items to cart" do
    test "retrieves the list of products added after putting a product in the cart" do
      user = User.new(%{id: "10001", name: "Bob"})
      product = %Product{name: "Comfy Sofa", sku: "comfy_sofa", stock_level: 5}

      assert :ok = Cart.add_to_cart(user, product)
      assert [^product] = Cart.get_items(user)
    end
  end
end
