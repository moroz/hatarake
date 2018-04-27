# frozen_string_literal: true

module Admin
  class OrdersController < Admin::BaseController
    expose(:orders) { Order.all.order(created_at: :desc) }

    def index; end

    def mark_paid
      @order = Order.find_by(unique_token: params[:id])
      @order.paid!
      flash[:notice] = 'Zamówienie zostało oznaczone jako opłacone.'
    rescue RuntimeError => e
      flash[:alert] = "RuntimeError: #{e.message}"
    ensure
      redirect_to @order
    end
  end
end
