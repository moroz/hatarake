class CartController < ApplicationController

  def show
    @cart = current_cart
    @cart_items = @cart.cart_items
  end

  def destroy
    current_cart.destroy
    redirect_to cart_path
  end

  def finalize
    currency = params[:currency].present? ? params[:currency] : nil
    order = current_cart.finalize!(currency)
    redirect_to order_payment_path(order)
  end
end
