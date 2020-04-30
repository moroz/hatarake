# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'InJobs.pl <kontakt@injobs.pl>'
  layout 'mailer'
end
