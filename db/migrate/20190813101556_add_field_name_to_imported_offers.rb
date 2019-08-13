class AddFieldNameToImportedOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :imported_offers, :field_name, :string
  end
end
