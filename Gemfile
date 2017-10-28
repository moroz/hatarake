source 'https://rubygems.org'
ruby '2.4.1'

gem 'activeadmin'
gem 'activerecord-reputation-system'
gem 'browser'
gem 'cancancan', '~> 2.0'
gem 'capistrano', '~> 3.8.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-rbenv', '~> 2.1'
gem 'carrierwave', '~> 1.1.0'
gem 'carrierwave-i18n'
gem 'carrierwave-unoconv'
gem 'coffee-rails', '~> 4.2'
gem 'cookies_eu'
gem 'decent_exposure'
gem 'devise'
gem 'devise-i18n'
gem 'factory_girl_rails'
gem 'faker', '~> 1.7.3'
gem 'file_validators'
gem 'fog-aws'
gem 'font-awesome-rails'
gem 'foundation-rails', '= 6.3.1.0'
gem 'foundation_emails'
gem 'friendly_id'
gem 'gretel'
gem 'haml', '~> 5.0.0'
gem 'inky-rb', require: 'inky'
gem 'invisible_captcha'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'mini_magick'
gem 'pg', '~> 0.18'
gem 'premailer-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.1'
gem 'rails-i18n'
gem 'rails-jquery-autocomplete'
gem 'redcarpet'
gem 'remotipart'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'valid_url'

# For XSLX exports
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'
gem 'rubyzip', '~> 1.1.0'

group :production, :staging do
  gem 'rollbar'
end

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

group :development do
  gem 'db_fixtures_dump'
  gem 'guard-livereload'
  gem 'guard-rspec', require: false
  gem 'listen', '~> 3.0.5'
  gem 'meta_request'
  gem 'rack-mini-profiler'
  gem 'seed_dump'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
