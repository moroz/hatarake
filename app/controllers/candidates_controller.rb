class CandidatesController < ApplicationController
  before_action :find_user
  helper_method :user

  def show
    if @user.profile.nil?
      redirect_to candidate_step2_path
    end
    @skill_items = @user.skill_items
  end

  def edit_skills
    @skill_items = current_user.skill_items
  end

  def step2
    @user.build_profile
  end

  private

  def user
    @user ||= find_user
  end

  def find_user
    if params[:id].present?
      @user = User.find(params[:id])
    elsif signed_in?
      @user = current_user
    end
  end
end
