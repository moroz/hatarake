class ApplicationsController < ApplicationController
  expose(:offer) { Offer.friendly.find(params[:offer_id]) }
  expose(:application)
  
  authorize_resource

  def create
    current_user.applications.new(application_params.merge({offer: offer}))
    if current_user.save
      redirect_to offer, notice: I18n.t('applications.create.notice')
    end
  end

  private

  def application_params
    params.require(:application).permit(:offer_id, :memo)
  end
end
