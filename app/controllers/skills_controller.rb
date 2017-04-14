class SkillsController < ApplicationController
  def create
    @skill = current_user.skills.new(skill_params)
    @skill.save
    redirect_to profile_edit_skills_path
  end

  def update
  end

  def destroy
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :level, :type, :candidate_id)
  end
end
