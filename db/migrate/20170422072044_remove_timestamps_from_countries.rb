# frozen_string_literal: true

class RemoveTimestampsFromCountries < ActiveRecord::Migration[5.0]
  def change
    remove_column :countries, :created_at
    remove_column :countries, :updated_at
  end
end
