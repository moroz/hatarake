class Candidate < User
  devise :registerable

  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged]

  has_many :skill_items, dependent: :destroy
  has_many :education_items, dependent: :destroy
  has_many :work_items, dependent: :destroy
  has_many :applications
  has_many :applied_offers, through: :applications, source: :offer
  has_many :offer_saves, class_name: "OfferSave", foreign_key: :user_id
  has_many :saved_offers, through: :offer_saves, source: :offer
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
        where("professions.name_en = :q OR professions.name_pl = :q", q: profession)
    else
      nil
    end
  end

  def self.search(term)
    joins(:profile).where("concat(candidate_profiles.first_name, ' ', candidate_profiles.last_name) ILIKE :q",
                          q: "%#{sanitize_sql_like(term)}%")
  end

  def profession_name
    return @profession_name if @profession_name.present?
    profession.try(:name_en)
  end

  def short_sex
    I18n.t("sexes.short.#{sex}")
  end

  private

  def name_for_slug
    if profile.present?
      [:full_name,
       [:full_name, SecureRandom.hex(3)],
       [:full_name, profile.age]
      ] 
    else
      SecureRandom.hex(8)
    end
  end

  def find_profession
    if self.profession_name.present?
      self.profession = Profession.find_or_create_by_name(self.profession_name)
    end
  end
end
