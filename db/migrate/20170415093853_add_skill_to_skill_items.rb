class AddSkillToSkillItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :skill_items, :name
    remove_column :skill_items, :name_pl
    remove_column :skill_items, :category
    add_reference :skill_items, :skill, foreign_key: true
  end
end
