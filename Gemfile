source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'rack-mini-profiler'

gem 'griddler'
gem 'griddler-mandrill'
gem 'omniauth-facebook'
gem 'foundation-rails'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring' 
  gem "rspec-rails"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem 'guard-rspec', '~> 4.5.0', require: false
  gem 'database_cleaner'
end