# frozen_string_literal: true

class AddFinalizedToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :finalized, :boolean, default: false
    add_column :carts, :finalized_at, :timestamp
  end
end
