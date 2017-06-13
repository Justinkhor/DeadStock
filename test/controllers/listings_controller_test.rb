require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { item: { address: @item.address, bed_number: @item.bed_number, city: @item.city, country: @item.country, description: @item.description, guest_number: @item.guest_number, place_type: @item.place_type, price_per_night: @item.price_per_night, property_type: @item.property_type, room_number: @item.room_number, state: @item.state, user_id: @item.user_id, zipcode: @item.zipcode } }
    end

    assert_redirected_to item_url(Item.last)
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { address: @item.address, bed_number: @item.bed_number, city: @item.city, country: @item.country, description: @item.description, guest_number: @item.guest_number, place_type: @item.place_type, price_per_night: @item.price_per_night, property_type: @item.property_type, room_number: @item.room_number, state: @item.state, user_id: @item.user_id, zipcode: @item.zipcode } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to items_url
  end
end
