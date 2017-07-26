# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( foundation_emails.scss pagedown.css pricing-table.scss Jcrop.js Jcrop.css jquery.rateyo.css jquery.rateyo.js Markdown.Converter.js Markdown.Editor.js Markdown.Sanitizer.js jquery.remotipart.js offers.js avatars.coffee owl.carousel.css owl.theme.css owl.carousel.js )
