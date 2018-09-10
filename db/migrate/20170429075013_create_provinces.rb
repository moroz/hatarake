# frozen_string_literal: true

class CreateProvinces < ActiveRecord::Migration[5.0]
  def change
    create_table :provinces do |t|
      t.references :country, foreign_key: true
      t.string :name_en
      t.string :name_pl
    end
  end
end
