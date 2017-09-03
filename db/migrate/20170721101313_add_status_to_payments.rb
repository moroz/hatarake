class AddStatusToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :status, :string
    add_column :payments, :currency, :string
    add_column :payments, :description, :string
    add_column :payments, :unique_token, :string
    add_column :payments, :payer_id, :integer
    add_column :payments, :item_id, :integer
    add_column :payments, :amount, :decimal, precision: 6, scale: 2
    remove_column :payments, :payment_fee, :decimal, precision: 6, scale: 2

    add_foreign_key :payments, :users, column: :payer_id 
    add_index :payments, :unique_token, unique: true
    add_index :payments, :description, unique: true
  end
end
