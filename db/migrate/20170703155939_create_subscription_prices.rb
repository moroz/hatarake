class CreateSubscriptionPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_prices do |t|
      t.string :name
      t.integer :duration
      t.decimal :price

      t.timestamps
    end
  end
end
