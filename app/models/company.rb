class Company < User
  devise :registerable
  has_and_belongs_to_many :fields
  has_many :offers, dependent: :destroy
  has_many :applications, through: :offers
  belongs_to :location
  validates :website, format: { with: URI::regexp, allow_blank: true }
  validates :name, uniqueness: true, presence: true 

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  scope :featured, -> { order('updated_at DESC') }
  scope :with_avg_rating, -> { find_with_reputation(:avg_rating, :all) }

  has_reputation :avg_rating, source: :user, aggregated_by: :average

  def display_name
    name
  end

  def recent_offers(limit = 5)
    self.offers.order(:published_at).limit(limit)
  end

  # If this query proves hard on the database, please consider
  # adding an offers_count to the database. However, Company is
  # an abstract model, as it is stored in the users table.
  def self.offer_counts
    self.unscoped.joins(:offers).select('users.id AS id, count(offers.id) AS count').group('users.id').reduce({}) do |acc, c|
      acc[c.id] = c.count
      acc
    end
  end
end
