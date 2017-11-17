class AddRequirementsAndFieldIdToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :req_lang_1, :integer, limit: 2
    add_column :offers, :req_lang_2, :integer, limit: 2
    add_column :offers, :field_id, :integer
    add_index :offers, :req_lang_1
    add_index :offers, :req_lang_2
    add_foreign_key :offers, :fields
  end
end
