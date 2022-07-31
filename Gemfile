source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bcrypt", "~> 3.1.7"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "rack-cors"
gem "rspec-rails"
gem "jbuilder"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
