# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :company, references: :users
      t.boolean :paid
      t.timestamp :paid_at
      t.timestamp :valid_thru

      t.timestamps
    end

    add_foreign_key :subscriptions, :users, column: :company_id
  end
end
