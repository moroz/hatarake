# frozen_string_literal: true

class AddLocationToEducationItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :education_items, :location, foreign_key: true
  end
end
