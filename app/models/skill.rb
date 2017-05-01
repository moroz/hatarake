class Skill < ApplicationRecord
  has_many :skill_items
  has_and_belongs_to_many :offers
  validates :name_en, uniqueness: true, presence: true
  validates :name_pl, uniqueness: true, allow_blank: true
  include FindOrCreate
  include ActsLikeAutocompletable
  include Localizable
end
