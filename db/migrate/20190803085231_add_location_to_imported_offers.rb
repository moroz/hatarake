class AddLocationToImportedOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :imported_offers, :location, :string
  end
end
