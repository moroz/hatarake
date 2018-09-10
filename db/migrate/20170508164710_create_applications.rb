# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.integer :candidate_id
      t.references :offer, foreign_key: true
      t.text :memo
      t.boolean :read

      t.timestamps
    end
    add_foreign_key :applications, :users, column: :candidate_id
  end
end
