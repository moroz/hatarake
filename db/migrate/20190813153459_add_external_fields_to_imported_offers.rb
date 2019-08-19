class AddExternalFieldsToImportedOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :imported_offers, :external_id, :string unless column_exists? :imported_offers, :external_id
    add_column :imported_offers, :external_url, :string unless column_exists? :imported_offers, :external_url
  end
end
