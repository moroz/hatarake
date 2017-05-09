class Offer < ApplicationRecord
  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged, :finders, :history]

  belongs_to :company, required: true
  belongs_to :country, required: true
  has_many :applications
  has_many :candidates, through: :applications
  belongs_to :province
  has_and_belongs_to_many :skills
  validates_presence_of :currency
  validates :title, presence: true, length: { minimum: 10, maximum: 85 }
  CURRENCIES = %w( pln eur chf usd gbp czk nok sek dkk )
  validates :currency, inclusion: { in: CURRENCIES }

  scope :published, -> { where(published: true) }
  scope :published_or_owned_by, ->(company) { where("published = ? OR company_id = ?", true, company.id) }
  scope :with_min_salary, 
    ->(min) { where("salary_min <= :min AND salary_max >= :min",
                    min: min) }
  scope :recent, -> { published.order('published_at DESC') }

  def salary
    format = if salary_min.present?
      if salary_max.present?
        if salary_min == salary_max
          'mineqmax'
        else
          'minmax'
        end
      else
        'min'
      end
    else
      if salary_max.present?
        'max'
      else
        'none'
      end
    end
    I18n.t("offers.salary.#{format}", min: salary_min, max: salary_max, currency: currency.upcase)
  end

  def publish
    self.update(published: true, published_at: Time.now)
  end

  def candidate_applied?(candidate)
    Application.where(candidate: candidate, offer: self).present?
  end

  def self.publish_all
    update_all(published:true, published_at: Time.now)
  end

  def self.search_by_query(query)
    country = "%#{sanitize_sql_like(query)}%"
    self.where("title ILIKE :q OR location ILIKE :q", q: country)
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

  def short_location
    if location.present?
      [location, country.local_name].join(', ')
    else
      country.local_name
    end
  end

  private

  def name_for_slug
    [
      [:title, :location],
      [:title, :location, SecureRandom.hex(3)]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed? || location_changed?
  end

end
