class AddExternalIdToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :external_id, :string
  end
end
