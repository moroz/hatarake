# frozen_string_literal: true

class ApplicationsMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  def new_application(application)
    @candidate = application.candidate
    @offer = application.offer
    @application = application
    @company = @offer.company

    I18n.with_locale(@company.locale || I18n.default_locale) do
      mail(to: @offer.application_email,
           subject: I18n.t('applications_mailer.new_application.subject',
                           candidate: @candidate.display_name, offer: @offer.title))
    end
  end
end
