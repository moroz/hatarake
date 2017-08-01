class CartItemsController < ApplicationController
  def create
    @item = current_user.cart.cart_items.new(cart_item_params)
    if @item.save
      redirect_to cart_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
