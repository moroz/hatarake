class RemoveSubscriptionIdSubscriptionPriceIdFromPayments < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :subscription_id, :integer
    remove_column :payments, :subscription_price_id, :integer
    remove_reference :payments, :item

    add_reference :subscriptions, :payment
  end
end
