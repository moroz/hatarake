# frozen_string_literal: true

class CreateOfferSaves < ActiveRecord::Migration[5.0]
  def change
    create_table :offer_saves do |t|
      t.integer :user_id
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
