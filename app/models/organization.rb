class Organization < ApplicationRecord
  extend FindOrCreate
  validates :name, presence: true, uniqueness: { allow_nil: true }
  validates :name_pl, uniqueness: { allow_nil: true }
  has_many :work_items
  has_many :education_items
end
