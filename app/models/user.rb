class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable
  validates :email, presence: true, uniqueness: true
  has_one :avatar, foreign_key: 'owner_id'
  extend FriendlyId
  friendly_id :name_for_slug, use: [:finders]

  def admin?
    self.type == "Admin"
  end

  def company?
    self.type == "Company"
  end

  def candidate?
    self.type == "Candidate"
  end
end
