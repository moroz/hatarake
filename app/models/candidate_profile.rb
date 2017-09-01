class CandidateProfile < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
  before_save :bump_lfw_at

  validates_presence_of :first_name, :last_name, :sex, :birth_date

  enum sex: {male: 1, female: 2}

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def bump_lfw_at
    if looking_for_work?
      self.lfw_at = Time.now
    else
      self.lfw_at = nil
    end
  end

  def bump_lfw_at!
    bump_lfw_at
    save
  end
end
