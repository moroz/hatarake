class AddCategoryToSkills < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :category, :string
  end
end
