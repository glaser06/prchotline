require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
# require 'contexts'
# require 'minitest_extensions'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  # Add more helper methods to be used by all tests here...

  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end

  def create_locations
    @loc = FactoryGirl.create(:location)
    @loc1 = FactoryGirl.create(:location, name: "loc1", phone: "123-456-7890", website: "loc1.com", active: true)
    @loc2 = FactoryGirl.create(:location, name: "loc2", phone: "023-456-7890", website: "loc2.com", active: true)
    @loc3 = FactoryGirl.create(:location, name: "loc3", phone: "323-456-7890", website: "loc3.com", active: true)
    @loc4 = FactoryGirl.create(:location, name: "loc4", phone: "523-456-7890", website: "loc4.com", active: false)
  end

  def remove_locations
    @loc.destroy
    @loc1.destroy
    @loc2.destroy
    @loc3.destroy
    @loc4.destroy
  end
end
