require 'test_helper'

class LocationTest < ActiveSupport::TestCase

    should have_many(:addresses)
    should have_many(:item_locations)
    should have_many(:items).through(:item_locations)

    should accept_nested_attributes_for :item_locations
    should accept_nested_attributes_for :addresses
    #TO DO: add proper testing for above

    should validate_presence_of(:name)

    should allow_value("4122683259").for(:phone)
    should allow_value("412-268-3259").for(:phone)
    should allow_value("412.268.3259").for(:phone)
    should allow_value("(412) 268-3259").for(:phone)
    should allow_value(nil).for(:phone)
    should_not allow_value("2683259").for(:phone)
    should_not allow_value("14122683259").for(:phone)
    should_not allow_value("4122683259x224").for(:phone)
    should_not allow_value("800-EAT-FOOD").for(:phone)
    should_not allow_value("412/268/3259").for(:phone)
    should_not allow_value("412-2683-259").for(:phone)

    context "Creating a location context" do
      setup do
        create_locations
      end

      teardown do
        remove_locations
      end

      should "show that all location objects are properly created" do
        assert_equal "loc1", @loc1.name
        assert_equal "loc2", @loc2.name
        assert_equal true, @loc3.active
        assert_equal false, @loc4.active
      end

      should "have a scope to alphabetize location" do
        assert_equal ["loc", "loc1", "loc2", "loc3", "loc4"], Location.alphabetical.map{|c| c.name}
      end

      should "have a scope to select only active location" do
        assert_equal ["loc1", "loc2", "loc3"], Location.active.alphabetical.map{|c| c.name}
      end

      should "have a scope to select only inactive location" do
        assert_equal ["loc", "loc4"], Location.inactive.alphabetical.map{|c| c.name}
      end

      should "have a scope to join county and location when inputted county_id" do

      end


    end
end
