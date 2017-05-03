class CandidatesController < ApplicationController
  before_action :find_candidate
  helper_method :candidate
  authorize_resource

  def index
    @candidates = Candidate.joins(:profile, :profession).page(params[:page])
  end

  def show
    if @candidate.profile.nil?
      redirect_to candidate_step2_path
    end
  end

  def update
    if current_candidate.update(candidate_params)
      flash[:success] = "Your profile has been saved."
      redirect_to profile_path
    else
      render 'step2'
    end
  end

  def edit_skills
    @skill_items = current_candidate.skill_items
  end

  def step2
    @candidate.build_profile unless @candidate.profile.present?
  end

  private

  def candidate
    @candidate ||= find_candidate
  end

  def find_candidate
    if params[:id].present?
      @candidate = Candidate.find(params[:id])
    elsif signed_in?
      @candidate = current_candidate
    end
  end

  def candidate_params
    params.require(:candidate).permit(:profession_name, profile_attributes: [:first_name, :last_name, :sex, :looking_for_work, :birth_date])
  end
end
