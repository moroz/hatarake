class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:updated_at).reverse
  end
end
