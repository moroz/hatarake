class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :cart, foreign_key: true
      t.string :currency, default: 'pln'
      t.string :unique_token
      t.string :payment_description
      t.string :payment_status
      t.timestamp :paid_at
      t.decimal :total, precision: 8, scale: 2

      t.timestamps
    end
  end
end
