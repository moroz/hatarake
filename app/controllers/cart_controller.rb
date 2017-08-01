class CartController < ApplicationController

  def show
    @cart = current_user.cart || current_user.create_cart
    @cart_items = @cart.cart_items
  end
end
