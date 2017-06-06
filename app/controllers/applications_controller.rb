class ApplicationsController < ApplicationController
  expose(:offer) { Offer.friendly.find(params[:offer_id]) }
  expose(:application)
  expose(:company) { offer.company }
  expose(:offer_applications) { offer.applications }
  
  authorize_resource

  def new
    if candidate_signed_in? && offer.candidate_applied?(current_candidate)
      redirect_to offer, alert: translate_with_gender('applications.already_applied', current_candidate.profile.sex)
    end
  end

  def create
    if Application.where(candidate: current_candidate, offer: offer).present?
      flash[:alert] = I18n.t('applications.create.failure')
    else
      current_user.applications.create(application_params.merge({offer: offer}))
      flash[:notice] = I18n.t('applications.create.notice')
    end
    redirect_to offer
  end

  def index
  end

  private

  def application_params
    params.require(:application).permit(:offer_id, :memo)
  end
end
