class ProfileController < ApplicationController
  before_action :set_user

  def show
    @skills = @user.skills
  end

  def edit_skills
    @skills = current_user.skills
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
