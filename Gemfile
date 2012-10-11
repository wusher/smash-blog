source 'https://rubygems.org'

gem 'rails', '3.2.8'
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
end

group :development, :test do 
  gem 'spork'
  gem 'pry'
  gem 'irbtools', :require => false
  gem 'rspec-rails'
  gem 'rr'
  gem 'rspec-given'
end
