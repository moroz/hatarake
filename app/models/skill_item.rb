class SkillItem < ApplicationRecord
  LEVELS = %w( 1_beginner 2_intermediate 3_good 4_expert )
  attr_accessor :skill_name

  default_scope { includes(:skill).ordered }
  scope :ordered, -> { order('level DESC', 'skills.name') }

  belongs_to :candidate
  belongs_to :skill
  validates_presence_of :skill, :level
  validates :level, inclusion: { in: LEVELS }
  validates :skill, uniqueness: { scope: :candidate_id, message: "You can't have two skills with the same name." }
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
