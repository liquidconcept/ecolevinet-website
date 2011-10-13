source 'http://rubygems.org'

# REFINERY CMS ================================================================
# Anything you put in here will be overridden when the app gets updated.

gem 'refinerycms',  '~> 1.0.4'

gem 'refinerycms-page-images',  '~> 1.0'
gem 'refinerycms-i18n',         '~> 1.0.0'

gem 'refinerycms-portfolio',     :git => 'git://github.com/ncouturier/refinerycms-portfolio.git'

gem 'refinerycms-sections',     '1.0', :path => 'vendor/engines'
# gem 'refinerycms-news',         '1.0', :path => 'vendor/engines'
# gem 'refinerycms-events',       '1.0', :path => 'vendor/engines'

gem 'compass',      '>= 0.11.5'

gem 'airbrake'

group :production do
  gem 'mysql2', '~> 0.2.7'
end

group :development, :test do
  gem 'sqlite3'

  # gem 'refinerycms-testing',    '~> 1.0.4'

  gem 'capistrano'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-sass'

  gem 'pry'

  gem 'rb-fsevent'
  gem 'growl'
end
