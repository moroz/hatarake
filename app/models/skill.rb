class Skill < ApplicationRecord
  has_many :skill_items
  has_and_belongs_to_many :offers
  extend FindOrCreate
end
