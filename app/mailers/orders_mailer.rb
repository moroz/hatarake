# frozen_string_literal: true

class OrdersMailer < ApplicationMailer
  def order_placed(order)
    @order = order
    @user = order.user
    @cart = order.cart
    @cart_items = @cart.cart_items
    @billing_address = @order.billing_address

    I18n.with_locale(@user.locale || I18n.default_locale) do
      mail(to: @user.email, subject: I18n.t('orders_mailer.order_placed.subject', order_id: @order.id))
    end
  end
end
