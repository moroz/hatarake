# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_cart, only: %i[place create], if: :logged_in?
  before_action :find_order, only: %i[show payment thank_you destroy]
  before_action :sign_in_to_proceed, only: %i[payment thank_you]

  authorize_resource except: %i[payment thank_you]

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
    render :place
  end

  def payment; end

  def thank_you
    return if @order.paid?
    redirect_to order_payment_path(@order)
  end

  def destroy
    if @order.paid?
      redirect_to @order, alert: t('orders.destroy.already_paid')
      return
    end
    return unless @order.destroy
    redirect_to orders_path, notice: t('orders.destroy.success')
  end

  private

  def find_order
    @order = Order.find_by(unique_token: params[:id] || params[:order_id])
  end

  def sign_in_to_proceed
    return unless current_user.try(:id) != @order.user_id
    sign_out(current_user) if logged_in?
    session[:return_to] = request.url
    redirect_to new_user_session_path, notice: I18n.t('orders.payment.redirection_notice')
    nil
  end

  def order_params
    params.require(:order)
          .permit(:currency, :invoice, :polish_taxpayer,
                 billing_address_attributes: [
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
