# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, comment: 'Only for Companies'
  end
end
