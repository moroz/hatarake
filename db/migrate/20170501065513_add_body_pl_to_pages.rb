# frozen_string_literal: true

class AddBodyPlToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :body_pl, :text
    rename_column :pages, :body, :body_en
  end
end
