class Company < User
  devise :registerable
  validates_presence_of :name
  has_many :offers
end
