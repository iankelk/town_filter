source 'https://rubygems.org'

gem 'rails'
gem 'jquery-rails'
gem "unicorn"
gem "pg"
gem "bootstrap-sass"
gem "hominid"
gem "devise"
gem "devise_invitable"
gem "cancan"
gem "rolify"
gem "simple_form"
gem "omniauth-twitter"

group :development do
	gem "quiet_assets"
	gem "hub", :require => nil
end

group :test do
	gem "database_cleaner"
	gem "email_spec"
	gem "cucumber-rails", :require => false
	gem "launchy"
	gem "capybara"
end

group :development, :test do
	gem "rspec-rails"
	gem "factory_girl_rails"
end

group :assets do
	gem 'sass-rails'
	gem 'coffee-rails'
 	gem 'uglifier'
end