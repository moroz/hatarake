Devise.setup do |config|
  config.secret_key = ENV.fetch('DEVISE_SECRET_KEY') { Rails.application.secrets.devise_secret_key } if Rails.env.production? || Rails.env.staging?
  config.mailer_sender = 'InJobs.pl <no-reply@injobs.pl>'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.send_email_changed_notification = false
  config.send_password_change_notification = false
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
