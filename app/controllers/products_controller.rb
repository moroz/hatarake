# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:order)
  end
end
