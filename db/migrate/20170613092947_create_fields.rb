# frozen_string_literal: true

class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.string :name_en
      t.string :name_pl

      t.timestamps
    end
  end
end
