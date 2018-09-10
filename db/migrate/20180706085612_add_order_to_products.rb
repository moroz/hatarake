# frozen_string_literal: true

class AddOrderToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :order, :integer
  end
end
