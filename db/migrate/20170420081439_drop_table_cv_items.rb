# frozen_string_literal: true

class DropTableCvItems < ActiveRecord::Migration[5.0]
  def change
    drop_table :cv_items
  end
end
