class ProfileController < ApplicationController
  before_action :find_user

  def show
    @skill_items = @user.skill_items
    @cv_items = @user.cv_items
  end

  def edit_skills
    @skill_items = current_user.skill_items
  end

  def edit_education
    @cv_items = @user.cv_items.education_items
  end

  def edit_work
    @cv_items = @user.cv_items.work_items
  end

  private

  def find_user
    if params[:id].present?
      @user = User.find(params[:id])
    elsif signed_in?
      @user = current_user
    end
  end
end
