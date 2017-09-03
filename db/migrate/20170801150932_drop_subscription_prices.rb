class DropSubscriptionPrices < ActiveRecord::Migration[5.1]
  def change
    drop_table :subscription_prices
  end
end
