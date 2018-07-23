class DeleteLocationFkOnOffers < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:offers, :locations)
      remove_foreign_key :offers, :locations
    end
  end
end
