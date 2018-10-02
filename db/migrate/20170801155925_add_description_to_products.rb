# frozen_string_literal: true

class AddDescriptionToProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :products do |t|
      t.column :description_en, :text
      t.column :description_pl, :text
    end
  end
end
