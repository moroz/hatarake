class CartItemsController < ApplicationController
  def create
    current_cart.add_item(cart_item_params[:product_id], cart_item_params[:quantity])
    respond_to do |f|
      f.js
      f.html { redirect_to cart_path }
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      respond_to do |f|
        f.js { render :update }
        f.html { redirect_to cart_path }
      end
    else
      redirect_to cart_path, alert: "The item could not be removed."
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
