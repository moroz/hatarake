class RemoveLocationIdFromImportedOffers < ActiveRecord::Migration[5.2]
  def change
    remove_column :imported_offers, :location_id, :integer
  end
end
