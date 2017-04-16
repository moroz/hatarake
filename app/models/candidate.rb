class Candidate < User
  devise :registerable
  validates_presence_of :first_name, :last_name
  has_many :skill_items
  has_many :cv_items

  default_scope { includes(:skill_items, :cv_items) }

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end
end
