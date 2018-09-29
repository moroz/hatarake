# frozen_string_literal: true

class CreateEmployers < ActiveRecord::Migration[5.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :city
      t.integer :country_id
      t.text :description

      t.timestamps
    end
  end
end
