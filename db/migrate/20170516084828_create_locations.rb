# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :country, foreign_key: true
      t.references :province, foreign_key: true
      t.string :city

      t.timestamps
    end
  end
end
