class Candidate < User
  devise :registerable
  validates_presence_of :first_name, :last_name
  has_many :skill_items, dependent: :destroy
  has_many :education_items, dependent: :destroy
  has_many :work_items, dependent: :destroy
  attr_accessor :profession_name

  belongs_to :profession

  scope :with_associations, -> { includes(:skill_items, :education_items, :work_items) }
  scope :looking_for_work, -> { where(looking_for_work: true) }
  
  def self.with_profession(profession)
    if profession.class == Profession
      where(profession: profession)
    elsif profession.class == String
      joins(:profession).
        where("professions.name = :q OR professions.name_pl = :q", q: profession)
    else
      nil
    end
  end

  before_validation :find_profession

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end

  private

  def find_profession
    if self.profession_name.present?
      self.profession = Profession.find_or_create_by_name(self.profession_name)
    end
  end
end
