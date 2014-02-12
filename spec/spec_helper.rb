def zeus_running?
  File.exists? '.zeus.sock'
end

unless zeus_running?
  require 'simplecov'
  require 'simplecov-rcov'
  require 'simplecov-console'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::RcovFormatter,
      SimpleCov::Formatter::Console
  ]
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'pp'
require 'capybara/rspec/matchers'
require 'shoulda-matchers'
require 'method_disabling'
require 'webmock/rspec'
require 'rspec-html-matchers'

FactoryGirl.find_definitions

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

unless Rails.env.test?
  puts "Rails Env is #{Rails.env} not test, aborting"
  exit(1)
end

RSpec.configure do |config|
  # For metadata in contexts
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # ## Mock Framework
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  #Include FactoryGirl helper methods
  config.include FactoryGirl::Syntax::Methods
  #config.include Sorcery::TestHelpers::Rails


  config.before do
  end

  config.before(:all) do
  end

  config.after(:all) do
  end

  config.before do
  end

  config.after do
  end
end

def ajax_html_doc
  return Nokogiri::HTML(response_as_json['html'])
end
