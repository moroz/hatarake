# frozen_string_literal: true

class ApplicationsController < ApplicationController
  expose(:offer) { Offer.friendly.find(params[:offer_id]) }
  expose(:application)
  expose(:company) { offer.company }
  expose(:offer_applications) { offer.applications }

  authorize_resource

  def new
    return unless candidate_signed_in?
    if offer.candidate_applied?(current_candidate)
      redirect_to(offer, alert:
        translate_with_gender('applications.already_applied', current_candidate.profile.sex)) && return
    end
    return unless current_candidate.not_updated_profile?
    redirect_to(edit_candidate_profile_path, alert: I18n.t('applications.new.candidate_profile_blank')) && return
  end

  def create
    if Application.where(candidate: current_candidate, offer: offer).present?
      flash[:alert] = I18n.t('applications.create.failure')
    else
      application = current_user.applications.create(application_params.merge(offer: offer))
      flash[:notice] = I18n.t('applications.create.notice')
      ApplicationsMailer.new_application(application).deliver
    end
    redirect_to offer
  end

  def my_offer_applications
    @applications = current_company.applications.includes(:offer).group_by(&:offer)
  end

  def index; end

  private

  def application_params
    params.require(:application).permit(:offer_id, :memo)
  end
end
