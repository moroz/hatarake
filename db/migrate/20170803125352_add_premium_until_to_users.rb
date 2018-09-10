# frozen_string_literal: true

class AddPremiumUntilToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :premium_until, :timestamp
  end
end
