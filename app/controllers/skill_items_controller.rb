class SkillItemsController < ApplicationController
  def create
    @skill_item = current_user.skill_items.new(skill_item_params)
    @skill_item.save
    redirect_to profile_edit_skills_path
  end

  def destroy
    @skill_item = current_user.skill_items.find(params[:id])
    @skill_item.destroy
    flash[:success] = "The skill has been deleted."
    redirect_to profile_edit_skills_path
  end

  private

  def skill_item_params
    params.require(:skill_item).permit(:skill_name, :level)
  end
end
