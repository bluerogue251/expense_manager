source "https://rubygems.org"

ruby "2.1.2"

gem "airbrake"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "neat", "~> 1.5.1"
gem "pg"
gem "rack-timeout"
gem "rails", "4.1.4"
gem "recipient_interceptor"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "title"
gem "uglifier"
gem "unicorn"
gem "clearance"
gem "font-awesome-rails"
gem 'jquery-datatables-rails', "~> 2.2.1"
gem 'year_month', github: 'bluerogue251/year_month'
gem 'kaminari'
gem 'bullet'
gem 'sunspot_rails'
gem 'faker'
gem "factory_girl_rails"
gem "progress_bar"
gem "redcarpet"
gem "ember-rails"
gem "ember-source", "1.5.0"
gem "emblem-rails"


group :development do
  gem "foreman"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 2.14.0"
  gem 'sunspot_solr'
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
  gem "sunspot_test"
  gem "coveralls", require: false
end

group :staging, :production do
  gem "rails_12factor"
  gem "newrelic_rpm", ">= 3.7.3"
end
