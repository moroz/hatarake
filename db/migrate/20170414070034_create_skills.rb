# frozen_string_literal: true

class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :name_pl
      t.string :level
      t.references :candidate

      t.timestamps
    end
  end
end
