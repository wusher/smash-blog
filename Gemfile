source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'heroku'

group :development, :test do 
  gem 'sqlite3'
end

group :production do 
  gem 'thin'
  gem 'pg'
end

gem 'devise'
gem 'jquery-rails'
gem 'haml-rails'
gem 'skeleton-rails'
gem 'underscore-rails'
gem 'turbolinks'

gem "redcarpet", "~> 2.1.1"
gem "coderay", "~> 1.0.8"

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end


group :development do
  gem 'guard'
  gem 'guard-rspec' 
  gem 'rb-fsevent', '~> 0.9.1'
  gem "terminal-notifier-guard", "~> 1.5.3"
  gem "better_errors", "~> 0.3.2"
  gem "bullet", "~> 4.3.0"
end

group :development, :test do 
  gem 'spork'
  gem 'pry'
  gem 'irbtools', :require => false
  gem 'rspec-rails'
  gem 'rspec-radar'
  gem 'rspec-fire'
  gem 'rspec-given'
end
