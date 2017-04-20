class SkillItemsController < ApplicationController
  respond_to :html, :js

  def create
    @skill_item = current_user.skill_items.new(skill_item_params)
    @skill_item.save
    respond_to do |f|
      f.html { redirect_to profile_edit_skills_path }
      f.js { @skill_items = current_user.skill_items }
    end
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
