class SkillItemsController < ApplicationController
  def create
    @skill_item = current_user.skill_items.new(skill_item_params)
    @skill_item.save
    respond_to do |f|
      f.html { redirect_to candidate_edit_skills_path }
      f.js do
        if @skill_item.errors.any?
          render 'show_errors'
        else
          @skill_items = current_user.skill_items
          render 'create'
        end
      end
    end
  end

  def destroy
    @skill_item = current_user.skill_items.find(params[:id])
    @skill_item.destroy
    flash[:success] = "The skill has been deleted."
    respond_to do |f|
      f.html { redirect_to candidate_edit_skills_path }
      f.js {
        @skill_items = current_user.skill_items
        render 'create'
      }
    end
  end

  def destroy_all
    current_user.skill_items.destroy_all
    respond_to do |f|
      f.html { redirect_to candidate_edit_skills_path }
      f.js
    end
  end

  private

  def skill_item_params
    params.require(:skill_item).permit(:skill_name, :level)
  end
end
