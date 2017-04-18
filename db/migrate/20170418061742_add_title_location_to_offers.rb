class AddTitleLocationToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :title, :string
    add_column :offers, :location, :string
  end
end
