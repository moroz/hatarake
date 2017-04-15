class RenameTableSkillsSkillItems < ActiveRecord::Migration[5.0]
  def change
    rename_table :skills, :skill_items
  end
end
