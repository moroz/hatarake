class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable
  has_one :avatar, dependent: :destroy

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
