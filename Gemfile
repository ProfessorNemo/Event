# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'aws-sdk-s3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'

# для проверки корректности введенного email
gem 'valid_email2', '~> 4.0'

gem 'image_processing', '~> 1.2'

# Гем, интегрирующий bootstrap
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'

# Переводы
gem 'devise-i18n'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-vkontakte'
gem 'rails-i18n'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'rspec', '~> 3.11'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

# Gemfile (очистить базу данных)
# https://github.com/DatabaseCleaner/database_cleaner
group :test do
  gem 'database_cleaner-active_record'
end

# гем для загрузки изображений
gem 'carrierwave', '~> 2.2'

# гем для обработки изображений
gem 'rmagick', '~> 4.2'

# гем для отправки почты в development
gem 'letter_opener'
gem 'mailjet', '~> 1.7'
gem 'pundit', '~> 2.2'
gem 'resque', '~> 2.4'
gem 'resque-scheduler', '~> 4.7'

gem 'cssbundling-rails', '~> 1.0'
gem 'jsbundling-rails', '~> 1.0'
gem 'sprockets-rails', '~> 3.4'

gem 'grape', '~> 1.7'
gem 'grape_on_rails_routes', '~> 0.3.2'
gem 'grape-swagger'
gem 'grape-swagger-rails'

gem 'rack-cors'
gem 'warden', '~> 1.2'
