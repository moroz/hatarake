class SkillItem < ApplicationRecord
  LEVELS = %w( beginner intermediate good expert )
  attr_accessor :skill_name

  belongs_to :candidate
  belongs_to :skill
  validates_presence_of :skill, :level
  validates :level, inclusion: { in: LEVELS }
  before_validation :find_or_create_skill
  delegate :name, to: :skill

  def level_key
    "skill_levels.#{level}"
  end

  private

  def find_or_create_skill
    self.skill = Skill.find_or_create_by_name(skill_name)
  end
end
