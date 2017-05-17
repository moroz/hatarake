class Company < User
  devise :registerable
  validates_presence_of :name
  has_many :offers, dependent: :destroy
  belongs_to :location
  validates :website, format: { with: URI::regexp, allow_blank: true }
  validates :name, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  scope :featured, -> { order('updated_at DESC') }

  def display_name
    name
  end
end
