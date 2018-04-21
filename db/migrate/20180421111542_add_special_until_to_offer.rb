class AddSpecialUntilToOffer < ActiveRecord::Migration[5.1]
  def change
  	add_column :offers, :special_until, :date
  end
end
