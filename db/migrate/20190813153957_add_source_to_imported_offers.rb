class AddSourceToImportedOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :imported_offers, :source, :string unless column_exists? :imported_offers, :source
  end
end
