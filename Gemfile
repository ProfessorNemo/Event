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
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

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
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
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