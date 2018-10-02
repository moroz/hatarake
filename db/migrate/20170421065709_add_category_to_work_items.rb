# frozen_string_literal: true

class AddCategoryToWorkItems < ActiveRecord::Migration[5.0]
  def change
    add_column :work_items, :category, :string
  end
end
