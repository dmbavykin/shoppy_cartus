$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shoppy_cartus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shoppy_cartus"
  s.version     = ShoppyCartus::VERSION
  s.authors     = ["Dmitriy Bavykin"]
  s.email       = ["1996@3g.ua"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ShoppyCartus."
  s.description = "TODO: Description of ShoppyCartus."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "pg"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  
  s.add_development_dependency 'factory_bot_rails'
end
