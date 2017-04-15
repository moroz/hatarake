class SkillItem < ApplicationRecord
  LEVELS = %w( beginner intermediate good expert )

  belongs_to :candidate
  validates_presence_of :name, :level
  validates :level, inclusion: { in: LEVELS }
end
