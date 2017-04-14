class Skill < ApplicationRecord
  LEVELS = %w( beginner intermediate expert )

  belongs_to :candidate
  validates_presence_of :name, :level
  validates :level, inclusion: { in: LEVELS }
end
