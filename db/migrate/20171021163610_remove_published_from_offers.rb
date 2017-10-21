class RemovePublishedFromOffers < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :published, :boolean, default: true
  end
end
