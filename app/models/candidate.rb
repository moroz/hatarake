class Candidate < User
  devise :registerable
  validates_presence_of :first_name, :last_name
  has_many :skill_items, dependent: :destroy
  has_many :education_items, dependent: :destroy
  has_many :work_items, dependent: :destroy

  default_scope { includes(:skill_items, :education_items, :work_items) }
  scope :looking_for_work, -> { where(looking_for_work: true) }

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end
end
