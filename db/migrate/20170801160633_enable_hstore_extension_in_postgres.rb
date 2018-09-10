# frozen_string_literal: true

class EnableHstoreExtensionInPostgres < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore'
  end
end
