# frozen_string_literal: true

class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :city
      t.string :country_id
      t.text :description

      t.timestamps
    end
  end
end
