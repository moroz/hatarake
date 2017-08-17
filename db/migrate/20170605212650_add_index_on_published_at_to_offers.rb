class AddIndexOnPublishedAtToOffers < ActiveRecord::Migration[5.0]
  def change
    add_index :offers, :published_at
  end
end
