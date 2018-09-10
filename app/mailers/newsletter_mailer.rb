# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def weekly_newsletter(subscriber)
    raise ArgumentError unless subscriber.is_a? NewsletterSubscription
    @name = subscriber.name
    @email = subscriber.email
    @offers = Offer.newsletter_digest

    mail(to: @email, subject: I18n.t('newsletter_mailer.new_application.subject'))
  end
end
