source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Configuration
gem "dotenv-rails"
gem "config"

# Core
gem "pg"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.3"
gem "bootsnap", ">= 1.4.2", require: false

# helpers
# gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem "faker"
# gem "rack-cors"
# gem "active_model_serializers"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.1"
  gem "factory_bot_rails"
end

group :development do
  gem "listen", "~> 3.2"
end
