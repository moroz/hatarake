class OfferSavesController < ApplicationController
  def create
    if offer.present? && can?(:create, OfferSave)
      OfferSave.create(offer: offer, user: current_user)
      redirect_to offer, notice: "You have saved this offer."
    end
  end

  def destroy
    if signed_in? && offer.user_saved?(current_user)
      OfferSave.where(offer: offer, user: current_user).first.destroy
      redirect_to offer, notice: "You have unsaved this offer."
    end
  end

  private

  def offer
    @offer ||= Offer.friendly.find(params[:offer_id])
  end
end
