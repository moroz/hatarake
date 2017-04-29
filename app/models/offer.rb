class Offer < ApplicationRecord
  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged, :finders]

  belongs_to :company, required: true
  belongs_to :country, required: true
  belongs_to :province
  has_and_belongs_to_many :skills
  validates_presence_of :currency
  validates :title, presence: true, length: { minimum: 10, maximum: 85 }
  CURRENCIES = %w( pln eur chf usd gbp )
  validates :currency, inclusion: { in: CURRENCIES }

  scope :published, -> { where(published: true) }
  scope :published_or_owned_by, ->(company) { where("published = ? OR company_id = ?", true, company.id) }

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
    I18n.t("offers.salary.#{format}", min: salary_min, max: salary_max, currency: currency)
  end

  def publish
    self.update(published: true, published_at: Time.now)
  end

  def self.publish_all
    update_all(published:true, published_at: Time.now)
  end

  def unpublish
    self.update(published: false)
  end

  private

  def name_for_slug
    [
      [:title, :location],
      [:title, :location, SecureRandom.hex(3)]
    ]
  end
end
