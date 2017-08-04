class RemovePaymentDescriptionFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :payment_description, :string

    add_index :orders, :unique_token, unique: true
  end
end
