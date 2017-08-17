class AddPublishedPublishedAtToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :published, :boolean
    add_column :offers, :published_at, :timestamp
  end
end
