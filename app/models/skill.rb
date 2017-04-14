class Skill < ApplicationRecord
  belongs_to :candidate
  validates_presence_of :name, :level
  validates :level, inclusion: { in: LEVELS }

  LEVELS = %w( beginner intermediate expert )
end
