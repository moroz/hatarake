# frozen_string_literal: true

class Candidate < User
  devise :registerable, :omniauthable, :omniauth_providers => [:facebook]

  extend FriendlyId
  friendly_id :name_for_slug, use: [:slugged]

  has_many :skill_items, dependent: :destroy
  has_many :education_items, dependent: :destroy
  has_many :work_items, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :resumes, foreign_key: 'owner_id', dependent: :destroy
  has_many :applied_offers, through: :applications, source: :offer
  has_many :offer_saves, class_name: 'OfferSave', foreign_key: :user_id
  has_many :saved_offers, through: :offer_saves, source: :offer
  has_one :profile, class_name: 'CandidateProfile', foreign_key: :user_id, dependent: :destroy

  accepts_nested_attributes_for :profile
  validates_presence_of :email

  delegate :sex, :looking_for_work, :first_name, :last_name, :full_name, :profession_name, :age, to: :profile
  delegate :display_name, to: :profile, allow_nil: true
  delegate :confirm_lfw, to: :profile

  scope :for_index, -> { joins(:profile).includes(:profile, :avatar) }
  scope :with_associations, -> { includes(:skill_items, :education_items, :work_items, :profile) }
  scope :looking_for_work, -> { joins(:profile).where('candidate_profiles.looking_for_work = ?', true) }

  def table_name
    profile&.display_name || email
  end

  def self.scope_from_params(params)
    raise ArgumentError, 'params should be an instance of Hash' unless params.is_a?(Hash)
    scope = order_by_param(params[:o])
    scope = scope.search_by_profession_name(params[:prid]) if params[:prid].present? 
    scope = scope.where('candidate_profiles.sex = ?', params[:sex]) if params[:sex].present?
    scope = scope.search(params[:q]) if params[:q].present?
    scope
  end

  def should_confirm_lfw?
    !not_updated_profile? && (!profile.lfw_at || profile.lfw_at < 2.days.ago)
  end

  def self.search_by_profession_name(profession)
    joins(:profile).where('candidate_profiles.profession_name ILIKE ?', "%#{sanitize_sql_like(profession.to_s)}%")
  end

  def self.with_profession(profession)
    joins(:profile).where(candidate_profiles: { profession_name: profession })
  end

  def self.order_by_full_name
    left_joins(:profile).includes(:profile).order('LOWER(candidate_profiles.first_name), LOWER(candidate_profiles.last_name), email')
  end

  def self.search(term)
    joins(:profile).where("concat(candidate_profiles.first_name, ' ', candidate_profiles.last_name) ILIKE :q",
                          q: "%#{sanitize_sql_like(term)}%")
  end

  def short_sex
    I18n.t("sexes.short.#{sex}")
  end

  def self.order_by_param(param)
    return all if param.blank?
    orders = ['candidate_profiles.first_name, candidate_profiles.last_name', 'candidate_profiles.birth_date',
              'candidate_profiles.sex', 'candidate_profiles.profession_name', 'candidate_profiles.lfw_at']
    order(orders[param.to_i])
  end

  def not_updated_profile?
    return true if profile.sex.nil? ||  profile.birth_date.nil? || profile.profession_name.nil? || profile.blank?
    return false
  end

  # Facebook login methods
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    # REVIEW: Consider adding provider column to users
    is_new_candidate = false
    record = User.where(email: auth.info.email).first_or_create do |candidate|
      is_new_candidate = candidate.new_record?
      candidate.email = auth.info.email
      candidate.password = Devise.friendly_token[0,20]
      candidate.type = "Candidate"
      candidate.build_profile
      candidate.profile.first_name = auth.info.name.split(" ")[0]
      candidate.profile.last_name = auth.info.name.split(" ")[1]
      candidate.skip_confirmation! 
      #user.avatar = auth.info.image # TODO
    end
    return [record, is_new_candidate]
  end

  private

  def name_for_slug
    if profile.present?
      [:full_name,
       [:full_name, SecureRandom.hex(3)],
       [:full_name, profile.age]]
    else
      SecureRandom.hex(8)
    end
  end

end
