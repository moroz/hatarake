class AddDefaultValueToCurrencyInPayments < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :currency, :string, default: 'pln'
  end
end