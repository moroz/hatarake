# frozen_string_literal: true

class AddLocationToWorkItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :work_items, :location, foreign_key: true
  end
end
