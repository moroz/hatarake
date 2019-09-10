# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_cart, only: %i[place create], if: :logged_in?
  before_action :find_order, only: %i[show payment thank_you destroy]
  before_action :sign_in_to_proceed, only: %i[payment thank_you]

  authorize_resource except: %i[payment thank_you]

  def index
    @orders = current_user.orders.order(:created_at)
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
      @order.deduction = current_user.reduce_balance(current_cart.total) if @order.currency == 'pln'
      @order.save!
      @order.cart.finalize!
    end
    if @order.amount_due.zero?
      @order.paid!
      @order.cart.cart_items.each do |cart_item|
        next if cart_item.offer_ids.nil?
        @offers = Offer.where(id: cart_item.offer_ids.split(','))
        premium_type = Product.find(cart_item.product_id).backend_name
        @offers.add_premium(premium_type)
      end
      redirect_to order_thank_you_path(order_id: @order.to_param)
      return
    end
    OrdersMailer.order_placed(@order).deliver
    redirect_to order_payment_path(@order)
  rescue ActiveRecord::RecordInvalid
    render :place
  end

  def payment
    dotpay_id = if @order.currency == 'eur'
                  Rails.application.secrets.dotpay_id_eur || '767542'
                else
                  Rails.application.secrets.dotpay_id_pln || '767542'
                end

    @signature = Digest::SHA256.hexdigest(
                   Rails.application.secrets.dotpay_secret + 'dev' + dotpay_id.to_s +
                   sprintf("%.2f", @order.amount_due) + @order.currency.upcase +
                   t('.payment_description') + @order.unique_token + order_thank_you_path(order_id: @order)
                 )
  end

  def thank_you
    redirect_to order_payment_path(@order) unless @order.paid?
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
                  billing_address_attributes: %i[
                    first_name last_name street house_no
                    apt_no postal_code city nip
                  ])
  end

  def set_cart
    @cart = current_cart
    return unless @cart.empty?
    redirect_to cart_path, alert: t('orders.place.cart_is_empty')
    nil
  end
end
