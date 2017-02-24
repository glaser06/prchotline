require 'test_helper'

class ItemCountiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_county = item_counties(:one)
  end

  test "should get index" do
    get item_counties_url
    assert_response :success
  end

  test "should get new" do
    get new_item_county_url
    assert_response :success
  end

  test "should create item_county" do
    assert_difference('ItemCounty.count') do
      post item_counties_url, params: { item_county: { description: @item_county.description } }
    end

    assert_redirected_to item_county_url(ItemCounty.last)
  end

  test "should show item_county" do
    get item_county_url(@item_county)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_county_url(@item_county)
    assert_response :success
  end

  test "should update item_county" do
    patch item_county_url(@item_county), params: { item_county: { description: @item_county.description } }
    assert_redirected_to item_county_url(@item_county)
  end

  test "should destroy item_county" do
    assert_difference('ItemCounty.count', -1) do
      delete item_county_url(@item_county)
    end

    assert_redirected_to item_counties_url
  end
end
