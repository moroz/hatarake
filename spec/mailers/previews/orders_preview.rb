class OrdersPreview < ActionMailer::Preview
  def order_placed
    order = Order.last
    OrdersMailer.order_placed(order)
  end
end
