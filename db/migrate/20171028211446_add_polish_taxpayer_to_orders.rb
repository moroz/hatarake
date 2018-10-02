# frozen_string_literal: true

class AddPolishTaxpayerToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :polish_taxpayer, :boolean, default: true
  end
end
