class ApplicationsController < ApplicationController
  expose(:offer) { Offer.friendly.find(params[:offer_id]) }
  expose(:application)
  
  authorize_resource

  def create
    if Application.where(candidate: current_candidate, offer: offer).present?
      flash[:alert] = I18n.t('applications.create.failure')
    else
      current_user.applications.create(application_params.merge({offer: offer}))
      flash[:notice] = I18n.t('applications.create.notice')
    end
    redirect_to offer
  end

  private

  def application_params
    params.require(:application).permit(:offer_id, :memo)
  end
end
