source 'http://rubygems.org'

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
gem 'figaro', '~> 1.1.0'
#gem 'aws-sdk', '~> 2'
#gem 'sidekiq', '~> 3.3.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'capistrano', '~> 3.1.0'

# rails specific capistrano funcitons
gem 'capistrano-rails', '~> 1.1.0'

# integrate bundler with capistrano
gem 'capistrano-bundler'

# if you are using RBENV
gem 'capistrano-rbenv', "~> 2.0" 

# Use the Unicorn app server
gem 'unicorn'

gem 'rack-mini-profiler'

gem 'griddler', '~> 1.1.0'
gem 'griddler-mandrill', '~> 1.0.2'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'foundation-rails', '~> 5.5.1.0'

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
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'capybara', '~> 2.4.4'
  gem 'guard-rspec', '~> 4.5.0', require: false
  gem 'database_cleaner', '~> 1.4.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'letter_opener', '~> 1.3.0'
  gem 'email_spec', '~> 1.6.0'
end

gem 'therubyracer', :platform => :ruby
