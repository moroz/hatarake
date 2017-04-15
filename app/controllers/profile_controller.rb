class ProfileController < ApplicationController
  before_action :set_user

  def show
    @skill_items = @user.skill_items
  end

  def edit_skills
    @skill_items = current_user.skill_items
  end

  private

  def set_user
    if params[:id].present?
      @user = User.find(params[:id])
    elsif signed_in?
      @user = current_user
    end
  end
end
