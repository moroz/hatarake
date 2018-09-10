# frozen_string_literal: true

class AddBackendNameToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :backend_name, :string, null: true
    add_index :products, :backend_name, unique: true
  end
end
