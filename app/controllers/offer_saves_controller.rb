# frozen_string_literal: true

class OfferSavesController < ApplicationController
  def create
    if current_user.nil?
      redirect_to(new_candidate_registration_path, notice: t('offers.offer_saves.fail_save_offer_notice')) && return
    end
    return unless offer.present? && can?(:create, OfferSave)
    OfferSave.create(offer: offer, user: current_user)
    redirect_to offer, notice: t('offers.offer_saves.save_offer_notice')
  end

  def destroy
    return unless logged_in? && offer.user_saved?(current_user)
    OfferSave.where(offer: offer, user: current_user).first.destroy
    redirect_to offer, notice: t('offers.offer_saves.unsave_offer_notice')
  end

  def email
    if current_user.nil?
      flash[:notice] = t('offers.offer_saves.fail_email')
    else
      flash[:notice] = t('offers.offer_saves.success_email')
      OfferSavesMailer.offer_saved(offer, current_user).deliver
    end
    redirect_to offer
  end

  private

  def offer
    @offer ||= Offer.friendly.find(params[:offer_id])
  end
end
