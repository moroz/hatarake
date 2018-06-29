class AddOfferIdToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :offer_id, :integer
  end
end
