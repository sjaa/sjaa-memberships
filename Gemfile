source "https://rubygems.org"

ruby "3.4.8"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
# Propshaft replacement asset pipeline that doesn't require sassc
gem "propshaft"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 7.0.3"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.20"
gem "pundit"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Debug
  gem 'pry-remote'
  gem 'pry-nav'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

# Required as bundled gem in Ruby 3.4+
# Pin to 5.x - minitest 6.0 has breaking API changes incompatible with Rails 7.1
gem "minitest", "~> 5.25"

gem 'pg'
gem 'csv'
gem 'pagy'
gem 'faker'
gem 'hotwire_combobox'
gem 'mail'
gem 'dotenv'
gem 'paypal-checkout-sdk'
gem 'ostruct'
gem 'googleauth'
gem 'pstore'
gem 'google-apis-admin_directory_v1'
gem 'google-apis-groupssettings_v1'
gem 'google-apis-calendar_v3'
gem 'google-apis-sheets_v4'

gem 'net-smtp', '~> 0.5.1'
gem "solid_queue", "1.1.0"

gem "aws-sdk-s3"
gem 'image_processing'
gem 'airbrake'
gem "mission_control-jobs"
gem 'connection_pool'

# Security udpates
gem "rack", ">= 3.2.3"
gem "rexml", ">= 3.4.2"
gem "nokogiri", ">= 1.18.9"
gem "rack-session", ">= 2.1.1"
gem "net-imap", ">= 0.5.7"
gem "uri", ">= 1.0.3"

# To authenticate to the GitHub Packages RubyGems registry, use one of the following methods:
# bundle config set --global https://rubygems.pkg.github.com/sjaa USERNAME:TOKEN
source "https://rubygems.pkg.github.com/sjaa" do
  gem "sjaa-ruby-calendar-aggregator", "0.5.1"
end

# Markdown support
gem 'redcarpet'

gem 'document-archive', ">= 0.2.3", github: 'cecomp64/document-archive', require: 'document_archive'