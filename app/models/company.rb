class Company < User
  devise :registerable
  has_many :offers, dependent: :destroy
  has_many :applications, through: :offers
  belongs_to :location
  validates :website, format: { with: URI::regexp, allow_blank: true }
  validates :name, uniqueness: true, presence: true 

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  scope :featured, -> { order('updated_at DESC') }

  def display_name
    name
  end
end
