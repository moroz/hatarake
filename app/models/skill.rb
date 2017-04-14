class Skill < ApplicationRecord
  LEVELS = %w( beginner intermediate expert good a2 b1 b2 c1 )

  belongs_to :candidate
  validates_presence_of :name, :level
  validates :level, inclusion: { in: LEVELS }
end
