source "https://rubygems.org"

# Ruby version for Docker and production. [https://www.ruby-lang.org/en/downloads/]
ruby "3.4.7"

# Full-stack web application framework. [https://github.com/rails/rails]
gem "rails", "~> 8.0.2", ">= 8.0.2.1"

# PostgreSQL database adapter for Active Record. [https://github.com/ged/ruby-pg]
gem "pg", "~> 1.1"

# Fast, concurrent web server for Ruby/Rack applications. [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Secure password hashing for has_secure_password. [https://github.com/bcrypt-ruby/bcrypt-ruby]
gem "bcrypt", "~> 3.1.7"

# JSON Web Token (JWT) implementation for authentication. [https://github.com/jwt/ruby-jwt]
gem "jwt"

# Rack middleware for handling Cross-Origin Resource Sharing (CORS). [https://github.com/cyu/rack-cors]
gem "rack-cors"

# In-memory data store for caching and session storage. [https://github.com/redis/redis-rb]
gem "redis", ">= 4.0.1"

# Background job processing framework. [https://github.com/sidekiq/sidekiq]
gem "sidekiq"

# Boot time optimization through caching. [https://github.com/Shopify/bootsnap]
gem "bootsnap", require: false

group :development, :test do
  # Static analysis scanner for security vulnerabilities. [https://brakemanscanner.org]
  gem "brakeman", require: false

  # Behavior-driven development testing framework for Rails. [https://github.com/rspec/rspec-rails]
  gem "rspec-rails", "~> 6.1"

  # Test fixture replacement with factories. [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails"

  # Library for generating realistic fake data. [https://github.com/faker-ruby/faker]
  gem "faker"

  # Enhanced Rails console with Pry. [https://github.com/pry/pry-rails]
  gem "pry-rails"

  # Step-through debugging for Pry. [https://github.com/deivid-rodriguez/pry-byebug]
  gem "pry-byebug"
end

group :development do
  # Ruby code linter and formatter. [https://github.com/rubocop/rubocop]
  gem "rubocop", require: false

  # RuboCop rules for Rails best practices. [https://github.com/rubocop/rubocop-rails]
  gem "rubocop-rails", require: false

  # RuboCop rules for RSpec tests. [https://github.com/rubocop/rubocop-rspec]
  gem "rubocop-rspec", require: false

  # RuboCop rules for performance optimization. [https://github.com/rubocop/rubocop-performance]
  gem "rubocop-performance", require: false
end

group :test do
  # Code coverage analysis tool. [https://github.com/simplecov-ruby/simplecov]
  gem "simplecov", require: false

  # RSpec matchers for common Rails functionality. [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "~> 6.0"
end
