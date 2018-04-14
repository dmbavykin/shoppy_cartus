ENV['RAILS_ENV'] ||= 'test'

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

ENGINE_ROOT = File.join(File.dirname(__FILE__), '../')
%w[support factories].each do |folder|
  Dir[File.join(ENGINE_ROOT, "spec/#{folder}/**/*.rb")].each do |file|
    require file
  end
end

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveModel
  config.include Shoulda::Matchers::ActiveRecord
  config.include FeatureHelper, type: :feature
  config.include I18n

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |matcher_config|
    matcher_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
