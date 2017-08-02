class CartController < ApplicationController

  def show
    @cart = current_cart
    @cart_items = @cart.cart_items
  end

  def destroy
    current_cart.destroy
    redirect_to cart_path
  end
end
