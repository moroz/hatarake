# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :subscription, foreign_key: true
      t.references :subscription_price, foreign_key: true
      t.decimal :payment_fee

      t.timestamps
    end
  end
end
