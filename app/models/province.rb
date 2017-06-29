class Province < ApplicationRecord
  belongs_to :country
  include Localizable

  def self.most_popular_voivodeships_with_counts
    r = ActiveRecord::Base.connection.execute(%Q(SELECT COUNT(o.id) AS cnt, p.id, p.name_#{I18n.locale} AS name FROM offers o JOIN locations l ON l.id = o.location_id JOIN provinces p ON l.province_id = p.id WHERE l.country_id = #{Country::POLAND_ID} GROUP BY name, p.id ORDER BY cnt, name DESC LIMIT 5))
    r.to_a
  end
end
