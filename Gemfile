# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in blake3ruby.gemspec
gemspec

gem "rb_sys"

group :development do
  gem "rake", "~> 13.0"
  gem "rake-compiler"
end

group :test do
  gem "rspec", "~> 3.0"
  gem "rubocop", "~> 1.21"
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end
