# frozen_string_literal: true

class DropTableProfessions < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :profession_id, :integer
    drop_table :professions
  end
end
