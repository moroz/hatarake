class SkillsController < ApplicationController
  def create
    @skill = current_user.skills.new(skill_params)
    @skill.save
    redirect_to profile_edit_skills_path
  end

  def destroy
    @skill = current_user.skills.find(params[:id])
    @skill.destroy
    flash[:success] = "The skill has been deleted."
    redirect_to profile_edit_skills_path
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :level, :type, :candidate_id)
  end
end
