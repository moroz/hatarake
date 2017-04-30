class RenameNameNameEnTables < ActiveRecord::Migration[5.0]
  def change
    rename_column :professions, :name, :name_en
    rename_column :skills, :name, :name_en
    rename_column :organizations, :name, :name_en
  end
end
