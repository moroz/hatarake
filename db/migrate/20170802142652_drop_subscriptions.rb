# frozen_string_literal: true

class DropSubscriptions < ActiveRecord::Migration[5.1]
  def change
    drop_table :subscriptions
  end
end
