# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'InJobs.pl <no-reply@injobs.pl>'
  layout 'mailer'
end
