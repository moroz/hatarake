class Admin::OrdersController < Admin::BaseController
  expose(:orders) { Order.all }

  def index
    
  end
end
