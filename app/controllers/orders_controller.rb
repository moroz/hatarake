class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_cart, only: [:place, :create], if: :logged_in?
  before_action :find_order, only: [:show, :payment, :thank_you, :destroy]

  authorize_resource

  def index
    @orders = current_user.orders
  end

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
    OrdersMailer.order_placed(@order).deliver
    redirect_to order_payment_path(@order)
  rescue ActiveRecord::RecordInvalid
    render :place and return
  end

  def thank_you
    unless @order.paid?
      redirect_to order_payment_path(@order) and return
    end
  end

  def destroy
    if @order.paid?
      redirect_to @order, alert: t('orders.destroy.already_paid')
      return
    end
    if @order.destroy
      redirect_to orders_path, notice: t('orders.destroy.success')
    end
  end

  private

  def find_order
    @order = Order.find_by(unique_token: params[:id])
  end

  def order_params
    params.require(:order).
      permit(:currency, :invoice, billing_address_attributes: [
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
