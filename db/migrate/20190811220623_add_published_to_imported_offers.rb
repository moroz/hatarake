class AddPublishedToImportedOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :imported_offers, :published, :boolean, default: false
  end
end
