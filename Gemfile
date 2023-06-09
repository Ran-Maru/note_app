source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_storage_validations', '0.8.2'
gem 'aws-sdk-s3', '1.46.0', require: false
gem 'bcrypt', '3.1.13'
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'bootsnap', '1.4.5', require: false
gem 'bootstrap-sass', '3.4.1'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'faker', '2.1.2'
gem 'image_processing', '1.9.3'
gem 'jbuilder', '2.9.1'
gem 'mini_magick', '4.9.5'
gem 'puma',       '4.3.6'
gem 'rails',      '6.0.3'
gem 'sass-rails', '5.1.0'
gem 'turbolinks', '5.2.0'
gem 'webpacker',  '4.0.7'
gem 'will_paginate', '3.1.8'

group :development, :test do
  gem 'byebug', '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '1.4.1'
  gem 'rspec-rails', '5.0.1'
  # カバレッジ取得
  gem 'simplecov'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'rubocop'
  gem 'rubocop-performance'

  gem 'rubocop-rails'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console',           '4.0.1'
end

group :test do
  gem 'capybara',                 '3.28.0'
  # ファイルの変更を検出して任意のタスクを自動実行する。
  gem 'guard',                    '2.16.2'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
end

group :production do
  gem 'mysql2', '0.5.3'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]