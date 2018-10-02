# frozen_string_literal: true

class CreateEducationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :education_items do |t|
      t.date :start_date
      t.date :end_date
      t.string :specialization
      t.references :organization, foreign_key: true
      t.integer :candidate_id
      t.string :memo

      t.timestamps
    end
    add_foreign_key :education_items, :users, column: :candidate_id
  end
end
