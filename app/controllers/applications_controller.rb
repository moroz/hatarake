class ApplicationsController < ApplicationController
  expose(:offer)
  expose(:application)

  def create
    current_user.applications.new(application_params.merge({offer: offer}))
    if current_user.save
      redirect_to offer, notice: I18n.t('.notice')
    end
  end

  private

  def application_params
    params.require(:application).permit(:offer_id, :memo)
  end
end
