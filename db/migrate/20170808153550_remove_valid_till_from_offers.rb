# frozen_string_literal: true

class RemoveValidTillFromOffers < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :valid_till, :date
  end
end
