require 'test_helper'

class CountyTest < ActiveSupport::TestCase
  should have_many(:addresses)
  # should have_many(:item_counties)
  # should have_many(:items).through(:item_counties)
  should validate_presence_of(:name)


end
