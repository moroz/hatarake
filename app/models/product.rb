class Product < ApplicationRecord
  include Localizable
  validates_presence_of :name_pl, :name_en, :price_eur, :price_pln
  validates_uniqueness_of :name_pl, :name_en
  validates_numericality_of :price_pln, :price_eur

  def test;end

  def price(currency = 'pln')
    self["price_#{currency}"]
  end

  def unit_price
    sprintf("%.2f PLN / %.2f&euro;", price_pln, price_eur).html_safe
  end

  def self.product_name_to_id(name)
    case name
      when 'highlight' then return 4
      when 'category' then return 3
      when 'homepage' then return 2
      when 4 then return 'highlight'
      when 3 then return 'category'
      when 2 then return 'homepage'
    else
      raise ActionController::BadRequest.new, "Unrecognized action"
    end
  end
end
