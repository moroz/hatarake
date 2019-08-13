class RemoveFieldIdFromImportedOffers < ActiveRecord::Migration[5.2]
  def change
    remove_column :imported_offers, :field_id, :integer
  end
end
