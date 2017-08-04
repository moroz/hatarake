class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_cart, only: [:place, :create]

  def place
    @order = Order.new
    @order.build_billing_address
  end

  def create
    @order = Order.new(order_params)
    @order.cart = current_cart
    @order.user = current_user
    @order.transaction do
      @order.save!
      @order.cart.finalize!
    end
    redirect_to order_payment_path(@order)
  rescue ActiveRecord::RecordInvalid
    render :place and return
  end

  def payment
    @order = Order.find_by(unique_token: params[:order_id])
  end

  private

  def order_params
    params.require(:order).
      permit(:currency, billing_address_attributes: [
        :first_name, :last_name, :street, :house_no,
        :apt_no, :postal_code, :city, :nip
    ])
  end

  def set_cart
    @cart = current_cart
    if @cart.empty?
      redirect_to cart_path, alert: t('orders.place.cart_is_empty')
      return
    end
  end
end
