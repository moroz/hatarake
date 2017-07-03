class Offer < ApplicationRecord
  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged, :finders, :history]
  attr_accessor :salary_min, :salary_max, :hourly_wage_min, :hourly_wage_max

  belongs_to :company, required: true
  belongs_to :location, required: true
  accepts_nested_attributes_for :location

  has_many :applications, dependent: :destroy
  has_many :candidates, through: :applications
  has_many :offer_saves, dependent: :destroy, class_name: "OfferSave"
  validates_presence_of :currency
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  CURRENCIES = %w( pln eur chf usd gbp czk nok sek dkk )
  validates :currency, inclusion: { in: CURRENCIES }

  delegate :country_id, to: :location
  delegate :province_id, to: :location

  delegate :name, to: :company, prefix: true

  before_validation :make_salary_range
  before_validation :make_hourly_wage

  default_scope { order('published_at DESC NULLS FIRST') }
  
  scope :poland, -> { joins(:location).where('locations.country_id = ?', Country::POLAND_ID) }
  scope :abroad, -> { joins(:location).where('locations.country_id != ?', Country::POLAND_ID) }

  scope :with_associations, -> { includes(:company, location: [:country]) }

  scope :published, -> { where(published: true) }
  
  def self.published_or_owned_by(company)
    if company.present?
      where('published = ? OR company_id = ?', true, company.id)
    else
      published
    end
  end
  
  scope :with_min_salary, ->(min) { where("salary @> :min or lower(salary) > :min", min: min.to_d) }
  scope :featured, -> { published.order('published_at DESC') }
  scope :with_country_id, ->(country_id) { joins(:location).where('locations.country_id = ?', country_id) }
  scope :with_province_id, ->(province_id) { joins(:location).where('locations.province_id = ?', province_id) }

  def self.advanced_search(o = {})
    scope = self.all
    if o[:cid].present?
      scope = scope.with_country_id(o[:cid])
    end
    if o[:pid].present?
      scope = scope.with_province_id(o[:pid])
    end
    if o[:q].present?
      scope = scope.search_by_query(o[:q])
    end
    if o[:smin].present?
      scope = scope.with_min_salary(o[:smin])
    end
    if o[:cur].present?
      scope = scope.where(currency: o[:cur])
    end
    scope
  end

  def publish
    self.update(published: true, published_at: Time.now)
  end

  def candidate_applied?(candidate)
    Application.where(candidate: candidate, offer: self).exists?
  end

  def user_saved?(user)
    OfferSave.where(user: user, offer: self).present?
  end

  def applicant_count_in_words
    I18n.t('offers.applicant_count', count: self.applications.count)
  end

  def self.publish_all
    where(published: false).update_all(published:true, published_at: Time.now)
  end

  def self.search_by_query(query)
    q = "%#{sanitize_sql_like(query)}%"
    joins(:location).where("title ILIKE :q OR locations.city ILIKE :q", q: q)
  end

  def unpublish
    self.update(published: false)
  end

  def full_location
    if province.present?
      [location, province.local_name, country.local_name].join(', ')
    else
      country.local_name + " – " + I18n.t('offers.provinces.blank')
    end
  end

  private

  def name_for_slug
    [
      [:title, self.location.city],
      [:title, self.location.city, SecureRandom.hex(3)]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed? || location_id_changed?
  end

  def make_salary_range
    min = self.salary_min
    max = self.salary_max
    if min.present? || max.present?
      self.salary = make_range(min, max)
    end
    if min == '' && max == ''
      self.salary = nil
    end
  end

  def make_hourly_wage
    min = self.hourly_wage_min
    max = self.hourly_wage_max
    if min.present? || max.present?
      self.hourly_wage = make_range(min, max)
    end
    if min == '' && max == ''
      self.hourly_wage = nil
    end
  end

  def make_range(min, max)
    if min.present? && max.present?
      if min.to_d > max.to_d
        min, max = max, min
      end
    end
    return "[#{min},#{max}]"
  end

end
