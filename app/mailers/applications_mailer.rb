class ApplicationsMailer < ApplicationMailer
  def new_application(application)
    @candidate = application.candidate
    @offer = application.offer
    @application = application
    #mail(to: @offer.application_email, 
  end
end
