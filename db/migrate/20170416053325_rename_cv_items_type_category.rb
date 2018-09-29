# frozen_string_literal: true

class RenameCvItemsTypeCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :cv_items, :type, :category
  end
end
