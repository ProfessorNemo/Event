# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'
gem 'foreman', '~> 0.87.2'

# для проверки корректности введенного email
gem 'valid_email2', '~> 4.0'

# Гем, интегрирующий bootstrap
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'

# Переводы
gem 'devise-i18n'
gem 'rails-i18n'

# Иконки флагов стран
gem 'flag-css-rails'
gem 'flag-icons-rails'
gem 'svg-flags-rails', '>= 1.0.0-beta' # ISO country flags https://github.com/steakknife/svg-flags/rails
# основной гем с иконками флагов
gem 'famfamfam_flags_rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 3.0'
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
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
gem 'pundit', '~> 2.2'
gem 'resque', '~> 2.4'
gem 'resque-scheduler', '~> 4.7'
