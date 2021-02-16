# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.1'

gem 'functions_framework', '~> 0.7'
gem 'sorbet-runtime', '~> 0.5'

group :development do
  gem 'sorbet', '~> 0.5'
end

group :test do
  gem 'rspec', '~> 3.10'
end

group :development, :test do
  gem 'byebug', '~> 11.1'
  gem 'rubocop', '~> 1.10', require: false
  gem 'rubocop-performance', '~> 1.9', require: false
  gem 'rubocop-rspec', '~> 2.2', require: false
  gem 'rubocop-sorbet', '~> 0.5'
end
