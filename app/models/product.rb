class Product < ApplicationRecord
  include Localizable
  validates_presence_of :name_pl, :name_en, :price_eur, :price_pln
  validates_uniqueness_of :name_pl, :name_en
  validates_numericality_of :price_pln, :price_eur

  def unit_price
    sprintf("%.2f PLN / %.2f&euro;", price_pln, price_eur).html_safe
  end
end
