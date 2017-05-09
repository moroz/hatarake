class Company < User
  devise :registerable
  validates_presence_of :name
  has_many :offers, dependent: :destroy

  scope :featured, -> { order('updated_at DESC') }

  def display_name
    name
  end
end
