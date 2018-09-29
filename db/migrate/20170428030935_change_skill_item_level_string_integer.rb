# frozen_string_literal: true

class ChangeSkillItemLevelStringInteger < ActiveRecord::Migration[5.0]
  def up
    change_column :skill_items, :level, 'integer USING CAST(level AS integer)'
  end

  def down
    change_column :skill_items, :level, :string
  end
end
