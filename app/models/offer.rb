# frozen_string_literal: true

class Offer < ApplicationRecord
  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged, :finders, :history]
  attr_accessor :salary_min, :salary_max, :hourly_wage_min, :hourly_wage_max

  belongs_to :company, required: true
  belongs_to :location, required: true
  belongs_to :field
  accepts_nested_attributes_for :location

  has_many :applications, dependent: :destroy
  has_many :candidates, through: :applications
  has_many :offer_saves, dependent: :destroy, class_name: 'OfferSave'
  validates_presence_of :currency
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  CURRENCIES = %w[pln eur chf usd gbp czk nok sek dkk].freeze
  validates :currency, inclusion: { in: CURRENCIES }
  validates :application_url, url: true, if: :apply_on_website?

  delegate :country_id, to: :location
  delegate :province_id, to: :location

  delegate :name, to: :company, prefix: true

  before_validation :make_required_languages
  before_validation :make_salary_range
  before_validation :make_hourly_wage
  after_validation :add_http_to_application_url

  before_create :publish
  after_create :update_offers_count_on_company
  after_update :update_offers_count_on_company

  default_scope { order('published_at DESC') }

  scope :featured_first, -> { reorder('(category_until IS NOT NULL AND category_until > NOW()) DESC', 'published_at DESC') }
  scope :by_publishing_date_nulls_first, -> { reorder('published_at DESC NULLS FIRST') }

  scope :poland, -> { joins(:location).where('locations.country_id = ?', Country::POLAND_ID) }
  scope :abroad, -> { joins(:location).where('locations.country_id != ?', Country::POLAND_ID) }

  scope :with_associations, -> { includes(company: :avatar, location: %i[country province]) }

  scope :published, -> { where('published_at IS NOT NULL') }

  def self.published_or_owned_by(company)
    if company.present?
      where('published_at IS NOT NULL OR company_id = ?', company.id).by_publishing_date_nulls_first
    else
      published
    end
  end

  scope :with_min_salary, ->(min) { where('salary @> :min or lower(salary) > :min', min: min.to_d) }
  scope :with_country_id, ->(country_id) { joins(:location).where('locations.country_id = ?', country_id) }
  scope :with_province_id, ->(province_id) { joins(:location).where('locations.province_id = ?', province_id) }
  scope :no_lang_required, -> { where(req_lang_1: 1) }

  scope :homepage_featured, -> { where('featured_until > NOW()') }
  scope :category_featured, -> { where('category_until > NOW()') }
  scope :highlighted, -> { where('highlight_until > NOW()') }
  scope :social_featured, -> { where('social_until > NOW()') }
  scope :special_featured, -> { where('special_until > NOW()') }
  scope :not_category_featured, -> { where('category_until IS NULL OR category_until < NOW()') }

  def self.advanced_search(o = {})
    scope = all
    scope = scope.with_country_id(o[:cid]) if o[:cid].present?
    scope = scope.with_province_id(o[:pid]) if o[:pid].present?
    scope = scope.search_by_query(o[:q]) if o[:q].present?
    scope = scope.with_min_salary(o[:smin]) if o[:smin].present?
    scope = scope.where(currency: o[:cur]) if o[:cur].present?
    scope = scope.where(field_id: o[:fid]) if o[:fid].present?
    scope = scope.no_lang_required if o[:lr].to_i == 1
    scope
  end

  def self.newsletter_digest
    published.where('published_at > ?', 1.week.ago).order(views: :desc).limit(10)
  end

  def language_requirements
    return if req_lang_1.nil?
    [req_lang_1, req_lang_2].map do |lang|
      I18n.t(lang, scope: 'language_requirements.languages') if lang
    end.compact.join(', ')
  end

  def featured?(type = nil)
    case type
    when 'highlight'
      highlighted?
    when 'category'
      category_featured?
    when 'homepage'
      homepage_featured?
    when 'social'
      social_featured?
    when 'special'
      special_featured?
    when nil
      highlighted? || category_featured? || homepage_featured? || social_featured? || special_featured?
    else
      raise ArgumentError
    end
  end

  def published?
    !!published_at
  end

  def highlighted?
    highlight_until && highlight_until > Time.now
  end

  def category_featured?
    category_until && category_until > Time.now
  end

  def homepage_featured?
    featured_until && featured_until > Time.now
  end

  def social_featured?
    social_until && social_until > Time.now
  end

  def special_featured?
    special_until && special_until > Time.now
  end

  def publish
    self.published_at = Time.now
    save if persisted?
  end

  def candidate_applied?(candidate)
    Application.where(candidate: candidate, offer: self).exists?
  end

  def user_saved?(user)
    OfferSave.where(user: user, offer: self).present?
  end

  def applicant_count_in_words
    I18n.t('offers.applicant_count', count: applications.count)
  end

  def application_email
    contact_email || company.contact_email || company.email
  end

  def self.publish_all
    where('published_at IS NULL').update_all(published_at: Time.now)
  end

  def add_premium(type)
    column = Offer.premium_column(type)
    return false if self[column].present? && self[column] > Time.now
    update(column => (Time.now + 1.month))
  end

  def self.add_premium(type)
    column = premium_column(type)
    offers = where("#{column} is null or #{column} < now()")
    count = offers.count
    return true if count.zero?
    return false unless offers.first.company.reduce_premium_services(type, count)
    offers.update_all(column => (Time.now + 1.month))
    true
  end

  def self.unpublish_all
    published.update_all(published_at: nil)
  end

  def self.search_by_query(query)
    queries = query_variations(query)
    sanitized_queries = queries.map { |q| "%#{sanitize_sql_like(q)}%" }
    joins(:location).where("title ILIKE ANY(ARRAY[:q]) OR locations.city ILIKE ANY(ARRAY[:q])", q: sanitized_queries)
  end

  def unpublish
    update(published_at: nil)
  end

  def full_location
    if province.present?
      [location, province.local_name, country.local_name].uniq.join(', ')
    else
      country.local_name + ' – ' + I18n.t('offers.provinces.blank')
    end
  end

  private

  def self.query_variations(query)
    query = [query, query.squeeze, query.gsub('v','w'), query.squeeze.gsub('n','nn'), query.squeeze.gsub('v','w'),
            query.squeeze.gsub('w','v'), query.squeeze.gsub('n','nn').gsub('w','v')].uniq
  end

  def name_for_slug
    [
      [:title, location.city],
      [:title, location.city, SecureRandom.hex(3)]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || will_save_change_to_attribute?(:title) || will_save_change_to_attribute?(:location_id)
  end

  def make_required_languages
    if req_lang_1.nil? || req_lang_1.to_i == 1 ||
       req_lang_2 == req_lang_1 || req_lang_2.to_i == 1
      self.req_lang_2 = nil
    end
  end

  def make_salary_range
    min = salary_min
    max = salary_max
    self.salary = make_range(min, max) if min.present? || max.present?
    self.salary = nil if min == '' && max == ''
  end

  def make_hourly_wage
    min = hourly_wage_min
    max = hourly_wage_max
    self.hourly_wage = make_range(min, max) if min.present? || max.present?
    self.hourly_wage = nil if min == '' && max == ''
  end

  def make_range(min, max)
    if min.present? && max.present?
      min = min.sub(',', '.').gsub(/[^\d\.]/, '') if min.is_a?(String)
      max = max.sub(',', '.').gsub(/[^\d\.]/, '') if max.is_a?(String)
      min, max = max, min if min.to_d > max.to_d
    end
    "[#{min},#{max}]"
  end

  def add_http_to_application_url
    application_url = add_http_to_url(application_url)
  end

  def self.premium_column(type)
    case type
    when 'highlight'
      return 'highlight_until'
    when 'homepage'
      return 'featured_until'
    when 'category'
      return 'category_until'
    when 'social'
      return 'social_until'
    when 'special'
      return 'special_until'
    else
      raise ArgumentError.new
    end
  end

  def update_offers_count_on_company
    count = Offer.where('published_at IS NOT NULL AND company_id = ?', company_id).count
    return if company.published_offers_count == count
    company.update_column(:published_offers_count, count)
  end
end
