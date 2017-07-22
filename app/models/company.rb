class Company < User
  devise :registerable
  has_and_belongs_to_many :fields
  has_many :offers, dependent: :destroy
  has_many :applications, through: :offers
  has_many :subscriptions
  belongs_to :location
  validates :name, uniqueness: true, presence: true 

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  scope :premium_users, -> { joins(:subscriptions).where('subscriptions.valid_until > NOW()').distinct }
  scope :featured, -> { order('users.updated_at DESC') }
  scope :with_avg_rating, -> { find_with_reputation(:avg_rating, :all) }

  has_reputation :avg_rating, source: :user, aggregated_by: :average

  def display_name
    name
  end

  def ratings_count
    ReputationSystem::Evaluation.where(target_id: id).count
  end

  def user_rating(user)
    ReputationSystem::Evaluation.where(target_id: id, source_id: user.id).last.try(:value)
  end

  def subscriptions_valid_until
    last_subscription.valid_until
  end

  def has_valid_subscription?
    subscriptions.valid.exists?
  end

  alias :premium? :has_valid_subscription?

  def current_subscription
    subscriptions.valid.order('valid_until').first
  end

  def last_subscription
    subscriptions.valid.order(valid_until: :desc).first
  end

  def sex
    nil
  end

  def recent_offers(limit = 5)
    self.offers.order(:published_at).limit(limit)
  end

  # If this query proves hard on the database, please consider
  # adding an offers_count to the database. However, Company is
  # an abstract model, as it is stored in the users table.
  def self.offer_counts
    self.unscoped.joins(:offers).select('users.id AS id, count(offers.id) AS count').group('users.id').reduce({}) do |acc, c|
      acc.merge({c.id => c.count})
    end
  end
end
