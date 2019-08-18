# frozen_string_literal: true

class CandidateProfile < ApplicationRecord
  belongs_to :candidate, dependent: :destroy, optional: :true

  validates_presence_of :first_name, :last_name
  validates_presence_of :sex, :birth_date, :profession_name, on: :update
  validates :first_name, :last_name, format: { with: /\A([^\d\W]|[-]|[zżźćńółęąśŻŹĆĄŚĘŁÓŃ])*\Z/ }

  enum sex: { male: 1, female: 2 }

  def full_name
    first_name + ' ' + last_name
  end

  def display_name
    full_name
  end

  def age
    return if birth_date.nil?
    now = Time.now.utc.to_date
    birth_in_future = (now.month == birth_date.month && now.day >= birth_date.day)
    now.year - birth_date.year - (now.month > birth_date.month || birth_in_future ? 0 : 1)
  end

  def confirm_lfw(looking_for_work = true)
    update(looking_for_work: looking_for_work, lfw_at: Time.now)
  end
end
