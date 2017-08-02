class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment
    @order = Order.find_by(unique_token: params[:order_id])
  end
end
