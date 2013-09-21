source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'heroku', "~> 2.40.0"

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'thin', "~> 1.5.1"
  gem 'pg', "~> 0.16.0"
  gem 'rails_12factor', "~> 0.0.2"
end

gem 'devise', "~> 3.1.0"
gem 'jquery-rails', "~> 3.0.4"
gem 'haml-rails', "~> 0.4"
gem 'skeleton-rails', "~> 0.1.0"
gem 'underscore-rails'
gem "turbolinks", "~> 1.3.0"

gem 'memcachier'
gem 'dalli'

gem "redcarpet", "~> 2.1.1"
gem "coderay", "~> 1.0.9"
gem "truncate_html", "~> 0.9.2"

gem 'newrelic_rpm', "~> 3.6.6.147"

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails', "~> 4.0.0"
gem 'coffee-rails', "~> 4.0.0"
gem 'therubyracer'
gem 'uglifier', '>= 1.0.3'
gem "rack-mini-profiler", "~> 0.1.31"

group :development do
  gem 'guard', "~> 1.8.2"
  gem 'guard-rspec', "~> 3.0.2"
  gem 'rb-fsevent', '~> 0.9.1'
  gem "terminal-notifier-guard", "~> 1.5.3"
  gem "bullet", "~> 4.3.0"
end

group :development, :test do
  gem 'spork', "~> 0.9.2"
  gem 'pry', "~> 0.9.12.2"
  gem 'irbtools', "~> 1.5.0", :require => false
  gem 'rspec-rails', "~> 2.14.0"
  gem 'rspec-radar', "~> 0.1.0"
  gem 'rspec-fire', "~> 1.2.0"
  gem 'rspec-given', "~> 3.1.0"
end
