class OfferSavesMailer < ApplicationMailer
  
  def offer_saved(offer, user)
    @user = user
    @offer = offer
    I18n.with_locale(user.locale || I18n.default_locale) do
      mail(to: user.email, subject: I18n.t('offer_saves_mailer.offer_saved.subject'))
    end
  end
end
