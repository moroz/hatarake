class AddDeductionAmountDueToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :deduction, :decimal, precision: 6, scale: 2
    add_column :orders, :amount_due, :decimal, precision: 8, scale: 2
  end
end
