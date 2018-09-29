# frozen_string_literal: true

class AddValidTillToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :valid_till, :date
  end
end
