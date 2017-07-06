class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable
  validates :email, presence: true, uniqueness: true
  validates :contact_email, uniqueness: true, allow_blank: true
  validates :phone, uniqueness: true, allow_blank: true
  validates :website, format: { with: URI::regexp, allow_blank: true }
  has_one :avatar, foreign_key: 'owner_id'
  extend FriendlyId
  friendly_id :name_for_slug, use: [:finders]

  def company?
    self.type == "Company"
  end

  def candidate?
    self.type == "Candidate"
  end

  def set_locale(locale)
    self.update(locale: locale)
  end
end
