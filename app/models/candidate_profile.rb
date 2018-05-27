class CandidateProfile < ApplicationRecord
  belongs_to :candidate, dependent: :destroy

  validates_presence_of :first_name, :last_name, :sex, :birth_date, :profession_name
  validates_format_of :first_name, :last_name, :with => /[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ]/

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

  def confirm_lfw(looking_for_work = true)
    update(looking_for_work: looking_for_work, lfw_at: Time.now)
  end
end
