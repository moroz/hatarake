# frozen_string_literal: true

class AddTypeToSkills < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :type, :string
  end
end
