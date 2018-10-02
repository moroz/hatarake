# frozen_string_literal: true

class AddCountryToOffer < ActiveRecord::Migration[5.0]
  def change
    add_reference :offers, :country, foreign_key: true
  end
end
