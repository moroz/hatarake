# frozen_string_literal: true

class DropTablePages < ActiveRecord::Migration[5.0]
  def change
    drop_table :pages
  end
end
