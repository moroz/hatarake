class Country < ApplicationRecord
  include Localizable

  has_many :offers
  has_many :provinces
  scope :abroad, -> { where('id != ?', POLAND_ID) }
  validates_presence_of :iso, :name_en, :name_pl
  validates_uniqueness_of :iso, :name_en, :name_pl

  POLAND_ID = 166

  def self.most_popular_with_offer_counts
    # TODO: The results are non-deterministic, they vary from query to query
    r = ActiveRecord::Base.connection.execute(%Q(SELECT COUNT(offers.id) AS cnt, countries.id, countries.name_#{I18n.locale} AS name FROM offers JOIN locations ON locations.id = offers.location_id JOIN countries ON locations.country_id = countries.id WHERE locations.country_id != #{POLAND_ID} GROUP BY countries.id, countries.name_#{I18n.locale} ORDER BY cnt DESC, name LIMIT 5))
    r.to_a
  end
end
