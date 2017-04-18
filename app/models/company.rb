class Company < User
  devise :registerable
  validates_presence_of :name
  has_many :offers, dependent: :destroy

  def display_name
    name
  end
end
