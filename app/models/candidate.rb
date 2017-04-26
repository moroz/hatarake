class Candidate < User
  devise :registerable
  has_many :skill_items, dependent: :destroy
  has_many :education_items, dependent: :destroy
  has_many :work_items, dependent: :destroy
  has_one :profile, class_name: 'CandidateProfile', foreign_key: :user_id, dependent: :destroy

  accepts_nested_attributes_for :profile

  belongs_to :profession
  attr_accessor :profession_name
  before_validation :find_profession

  delegate :sex, :looking_for_work, :first_name, :last_name, :full_name, :display_name, to: :profile

  scope :with_associations, -> { includes(:skill_items, :education_items, :work_items, :profile) }
  scope :looking_for_work, -> { joins(:profile).where('candidate_profiles.looking_for_work = ?', true) }
  
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

  def profession_name
    return @profession_name if @profession_name.present?
    profession.name
  end

  private

  def find_profession
    if self.profession_name.present?
      self.profession = Profession.find_or_create_by_name(self.profession_name)
    end
  end
end
