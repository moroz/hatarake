# frozen_string_literal: true

class AddOfferIdToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :offer_id, :integer
  end
end
