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
end
