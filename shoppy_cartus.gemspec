$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shoppy_cartus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shoppy_cartus"
  s.version     = ShoppyCartus::VERSION
  s.authors     = ["Dmitriy Bavykin"]
  s.email       = ["1996@3g.ua"]
  s.homepage    = "https://github.com/6aBblKuH/shoppy_cartus"
  s.summary     = "ShoppyCartus as simple deсision of site cart"
  s.description = "Gem introduces the functionality of the basket and the order menu"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.1.5"
  s.add_dependency 'aasm', '~> 4.12', '>= 4.12.3'
  s.add_dependency 'bootstrap-sass', '~> 3.3.7'
  s.add_dependency 'cancancan', '~> 2.1', '>= 2.1.3'
  s.add_dependency 'country_select', '~> 3.1', '>= 3.1.1'
  s.add_dependency 'draper', '~> 3.0', '>= 3.0.1'
  s.add_dependency 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'
  s.add_dependency 'haml', '~> 5.0', '>= 5.0.4'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'simple_form', '~> 3.5', '>= 3.5.1'
  s.add_dependency 'turbolinks', '~> 5'
  s.add_dependency 'wicked', '~> 1.3', '>= 1.3.2'

  s.add_development_dependency 'pg', '~> 0.18'
  s.add_development_dependency 'rspec-rails', '~> 3.7', '>= 3.7.2'
  s.add_development_dependency 'capybara', '~> 2.18'
  s.add_development_dependency 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  s.add_development_dependency 'pry', '~> 0.11.3'
  s.add_development_dependency 'ffaker', '~> 2.8', '>= 2.8.1'
  s.add_development_dependency 'database_cleaner', '~> 1.6', '>= 1.6.2'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  s.add_development_dependency 'rubocop', '~> 0.54.0'
  s.add_development_dependency 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
end
