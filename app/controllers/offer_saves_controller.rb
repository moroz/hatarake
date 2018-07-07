class OfferSavesController < ApplicationController
  def create
    if current_user.nil?
      redirect_to new_candidate_registration_path, notice: t('offers.offer_saves.fail_save_offer_notice') and return
    end
    if offer.present? && can?(:create, OfferSave)
      OfferSave.create(offer: offer, user: current_user)
      redirect_to offer, notice: t('offers.offer_saves.save_offer_notice')
    end
  end

  def destroy
    if logged_in? && offer.user_saved?(current_user)
      OfferSave.where(offer: offer, user: current_user).first.destroy
      redirect_to offer, notice: t('offers.offer_saves.unsave_offer_notice')
    end
  end

  def email
    if current_user.nil?
      flash[:notice] = "Login to your account or create one to send offer to email."
    else
      flash[:notice] = "Offer has been sucessfully sent to your mailbox!"
      OfferSavesMailer.offer_saved(offer, current_user).deliver
    end
    redirect_to offer
  end

  private

  def offer
    @offer ||= Offer.friendly.find(params[:offer_id])
  end
end
