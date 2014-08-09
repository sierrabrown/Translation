# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def sign_up(username)
  visit "/session/new"
  click_link "signUpLink"
  fill_in "username", with: username
  fill_in "email", with: 'email@email.com'
  fill_in "password", with: 'abcdef'
  find('input[id="submitButton"]').click
end

def sign_up_as_hello_world
  sign_up("hello_world")
end

def sign_in(username)
  visit "/session/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign In'
end
