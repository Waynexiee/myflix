source 'https://rubygems.org'
ruby '2.2.9'


gem 'bootstrap-sass', '3.1.1.1'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'stripe'
gem 'figaro'
gem 'carrierwave'
gem 'mini_magick'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'fog'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr', '2.9.3'
  gem 'capybara'
  gem 'capybara-email'
end

group :production do
  gem 'pg', '~> 0.20'
  gem 'rails_12factor'
end
