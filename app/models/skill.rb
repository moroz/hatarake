class Skill < ApplicationRecord
  belongs_to :candidate
  validates_presence_of :name, :level
end
