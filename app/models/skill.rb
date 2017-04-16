class Skill < ApplicationRecord
  has_many :skill_items
  extend FindOrCreate
end
