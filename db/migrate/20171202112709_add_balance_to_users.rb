# frozen_string_literal: true

class AddBalanceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance, :decimal, precision: 8, scale: 2
  end
end
