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
    r = ActiveRecord::Base.connection.execute(%Q(SELECT COUNT(o.id) AS cnt, c.id, c.name_#{I18n.locale} AS name FROM offers o JOIN locations l ON l.id = o.location_id JOIN countries c ON l.country_id = c.id WHERE l.country_id != #{POLAND_ID} AND o.published GROUP BY c.id, name ORDER BY cnt DESC, name LIMIT 5))
    r.to_a
  end
end
