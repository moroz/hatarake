class CandidatesController < ApplicationController
  before_action :find_candidate
  helper_method :candidate
  authorize_resource

  def index
    @candidates = Candidate.joins(:profile).includes(:profile, :profession, :avatar).page(params[:page])
    if params[:o].present?
      order_candidates(params[:o])
    end
    if params[:prid].present?
      @candidates = @candidates.where(profession_id: params[:prid])
    end
    if params[:sex].present?
      @candidates = @candidates.where('candidate_profiles.sex = ?', params[:sex])
    end
    if params[:q].present?
      @candidates = @candidates.search(params[:q])
    end
    set_professions_list
  end

  def show
    if @candidate.profile.nil?
      redirect_to edit_candidate_profile_path
    end
  end

  def update
    @candidate = current_candidate
    if @candidate.update(candidate_params)
      if params[:candidate][:avatar].present?
        redirect_to crop_avatar_path
      else
        flash[:success] = I18n.t('candidates.update.success')
        redirect_to session.delete(:return_to) || profile_path
      end
    else
      respond_to do |f|
        f.html { render 'step2' }
        f.js { render_js_errors_for(@candidate) }
      end
    end
  end

  def edit_skills
    @skill_items = current_candidate.skill_items
  end

  def edit
    @candidate.build_profile unless @candidate.profile.present?
  end

  def confirm_lfw
    return if current_candidate.profile.blank?
    if params[:v].blank? || params[:v].to_i == 1
      @candidate.profile.update(looking_for_work: true, lfw_at: Time.now)
    else
      @candidate.profile.update(looking_for_work: false, lfw_at: nil)
    end
    respond_to do |f|
      f.html { redirect_to profile_path, notice: t('candidates.confirm_lfw.notice') }
      f.js
    end
  end

  private

  def set_professions_list
    @professions = Profession.all
  end

  def order_candidates(param)
    orders = ['candidate_profiles.first_name, candidate_profiles.last_name', 'candidate_profiles.birth_date', 'candidate_profiles.sex', 'professions.name_pl, professions.name_en', 'candidate_profiles.lfw_at']
    @candidates = @candidates.order(orders[param.to_i])
  end

  def candidate
    @candidate ||= find_candidate
  end

  def find_candidate
    if params[:id].present?
      @candidate = Candidate.friendly.find(params[:id])
    elsif logged_in?
      @candidate = current_candidate
    end
  end

  def candidate_params
    params.require(:candidate).permit(:profession_name, :description, :contact_email, :phone, profile_attributes: [:id, :first_name, :last_name, :sex, :looking_for_work, :birth_date])
  end
end
