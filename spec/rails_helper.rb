require 'paperclip/matchers'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include Paperclip::Shoulda::Matchers

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
