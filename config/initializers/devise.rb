# frozen_string_literal: true

Devise.setup do |config|
  config.secret_key = Rails.application.secrets.devise_secret_key if Rails.env.production? || Rails.env.staging?
  config.mailer_sender = 'InJobs.pl <kontakt@injobs.pl>'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.send_email_changed_notification = false
  config.send_password_change_notification = false
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  require 'omniauth-facebook'
  OmniAuth.config.logger = Rails.logger
  config.omniauth :facebook, Rails.application.secrets.FB_APP_ID, Rails.application.secrets.FB_SECRET_KEY,
                  callback_url: 'https://injobs.pl/api/users/auth/facebook/callback', token_params: { parse: :json }
  config.omniauth_path_prefix = '/api/users/auth'
end
