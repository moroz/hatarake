class AddProvinceToOffers < ActiveRecord::Migration[5.0]
  def change
    add_reference :offers, :province, foreign_key: true
  end
end
