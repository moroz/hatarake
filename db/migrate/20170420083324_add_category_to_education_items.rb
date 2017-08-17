class AddCategoryToEducationItems < ActiveRecord::Migration[5.0]
  def change
    add_column :education_items, :category, :string
  end
end
