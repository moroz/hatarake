# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :find_candidate
  helper_method :candidate
  after_action :set_lfw_at, only: :update
  authorize_resource

  def index
    respond_to do |format|
      unless request.format.xlsx?
        @candidates = Candidate.for_index.page(params[:page])
        @candidates = @candidates.scope_from_params(search_params)
      end
      format.js
      format.html
      format.xlsx do
        raise CanCan::AccessDenied unless admin_user_signed_in?
        @candidates = Candidate.order_by_full_name
        filename = Time.zone.now.strftime('%Y%m%d_kandydaci.xlsx')
        render xlsx: 'index', filename: filename
      end
    end
  end

  def mailing_list
    @collection = Candidate.order_by_full_name
    render 'mailing_list.txt', layout: false, content_type: 'text/plain'
  end

  def show
    redirect_to edit_candidate_profile_path if @candidate.profile.nil?
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
    # confirm or disable, depending on what the user clicked
    lfw = params[:v].blank? || params[:v].to_i == 1
    @candidate.confirm_lfw(lfw)
    respond_to do |f|
      f.html { redirect_to profile_path, notice: t('candidates.confirm_lfw.notice') }
      f.js
    end
  end

  private

  def set_lfw_at
    @candidate.profile.lfw_at = Time.now.utc if @candidate.profile&.persisted?
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

  def search_params
    params.permit(:o, :q, :prid, :sex).to_h
  end

  def candidate_params
    params.require(:candidate).permit(:description, :contact_email, :phone, profile_attributes: [:id, :first_name, :last_name, :sex, :looking_for_work, :birth_date, :profession_name])
  end
end
