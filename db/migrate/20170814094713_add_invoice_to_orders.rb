class AddInvoiceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :invoice, :boolean
  end
end
