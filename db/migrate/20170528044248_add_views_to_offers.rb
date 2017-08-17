class AddViewsToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :views, :integer, default: 0
  end
end
