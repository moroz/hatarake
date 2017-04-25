class CandidateProfile < ApplicationRecord
  belongs_to :candidate

  validates_presence_of :first_name, :last_name

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end
end
