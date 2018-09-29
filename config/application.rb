# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InJobs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    I18n.available_locales = %i[en pl]
    I18n.default_locale = :pl

    config.action_view.sanitized_allowed_tags = %w[code blockquote p span a i b em strong br
                                                   hr img h1 h2 h3 h4 h5 h6 small ul ol li]
    config.action_view.sanitized_allowed_attributes = %w[href src style]

    config.time_zone = 'Europe/Warsaw'
  end
end
