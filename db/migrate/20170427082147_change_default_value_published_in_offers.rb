class ChangeDefaultValuePublishedInOffers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :offers, :published, false
  end
end
