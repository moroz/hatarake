class CandidateProfile < ApplicationRecord
  belongs_to :candidate, dependent: :destroy

  validates_presence_of :first_name, :last_name
  validates :sex, presence: true

  enum sex: [:male, :female, :apache_helicopter]

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
end
