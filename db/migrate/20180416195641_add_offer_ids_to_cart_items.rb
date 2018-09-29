# frozen_string_literal: true

class AddOfferIdsToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items, :offer_ids, :string
  end
end
