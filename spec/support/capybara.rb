# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.ignore_hidden_elements = false
