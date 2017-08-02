class CartItemsController < ApplicationController
  def create
    current_cart.add_item(cart_item_params[:product_id], cart_item_params[:quantity])
    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
