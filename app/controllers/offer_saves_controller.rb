class OfferSavesController < ApplicationController
  def create
    @offer = Offer.friendly.find(params[:offer_id])
    if @offer.present? && can?(:create, OfferSave)
      OfferSave.create(offer: @offer, candidate: current_candidate)
      redirect_to @offer, notice: "You have saved this offer."
    end
  end
end