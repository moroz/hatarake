class SkillItem < ApplicationRecord
  LEVELS = %w( 1_beginner 2_intermediate 3_good 4_expert )
  attr_accessor :skill_name

  default_scope { includes(:skill).ordered }
  scope :ordered, -> { order('level DESC', 'skills.name') }

  belongs_to :candidate, required: true
  belongs_to :skill, required: true
  validates :level, inclusion: { in: LEVELS }, presence: true
  validates :skill, uniqueness: { scope: :candidate_id, if: -> { skill.present? } }
  before_validation :find_or_create_skill
  delegate :name, to: :skill

  def level_key
    "skill_levels.#{level}"
  end

  private

  def find_or_create_skill
    self.skill = skill_name.present? ? Skill.find_or_create_by_name(skill_name) : nil
  end
end
