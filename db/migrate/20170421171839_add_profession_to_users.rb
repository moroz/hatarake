# frozen_string_literal: true

class AddProfessionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :profession, foreign_key: true
  end
end
