class CandidatesController < ApplicationController
  before_action :find_user
  helper_method :user

  def index
    @candidates = Candidate.joins(:profile, :profession).page(params[:page])
  end

  def show
    if @user.profile.nil?
      redirect_to candidate_step2_path
    end
    @skill_items = @user.skill_items
  end

  def update
    if current_user.update(candidate_params)
      flash[:success] = "Your profile has been saved."
      redirect_to profile_path
    else
      render 'step2'
    end
  end

  def edit_skills
    @skill_items = current_user.skill_items
  end

  def step2
    @user.build_profile unless @user.profile.present?
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

  def candidate_params
    params.require(:candidate).permit(:profession_name, profile_attributes: [:first_name, :last_name, :sex, :looking_for_work, :birth_date])
  end
end
