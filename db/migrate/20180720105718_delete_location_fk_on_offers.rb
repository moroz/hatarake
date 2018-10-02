# frozen_string_literal: true

class DeleteLocationFkOnOffers < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :offers, :locations if foreign_key_exists?(:offers, :locations)
  end
end
