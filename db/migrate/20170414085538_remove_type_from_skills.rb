# frozen_string_literal: true

class RemoveTypeFromSkills < ActiveRecord::Migration[5.0]
  def change
    remove_column :skills, :type
  end
end
