# frozen_string_literal: true

class AddDefaultValueToPaidInSubscriptions < ActiveRecord::Migration[5.0]
  def change
    change_column :subscriptions, :paid, :boolean, default: false
  end
end
