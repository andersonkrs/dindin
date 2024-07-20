source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "~> 7.2.0.beta2"

gem "bootsnap", require: false

gem "puma", ">= 5.0"

# Drivers
gem "sqlite3", ">= 2.0.2"
gem "activerecord-enhancedsqlite3-adapter"

# Redis
gem "redis", ">= 4.0.1"

# Solid gems
gem "solid_queue"
gem "solid_errors"

# Queue management
gem "mission_control-jobs"

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# Bundling
gem "propshaft"
gem "jsbundling-rails"
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Password encryption
gem "bcrypt", "~> 3.1.7"

# Handles monetization
gem "money-rails", "~> 1.12"

# Active Storage
gem "image_processing", "~> 1.2"
gem "aws-sdk-s3", require: false

# Pagination
gem "geared_pagination"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
