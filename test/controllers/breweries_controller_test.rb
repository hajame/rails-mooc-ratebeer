require "test_helper"

class BreweriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brewery = breweries(:one)
  end

  test "should get index" do
    get breweries_url
    assert_response :success
  end

  test "should get new" do
    get new_brewery_url
    assert_response :success
  end

  test "should create brewery" do
    assert_difference("Brewery.count") do
      post breweries_url, params: { brewery: { name: @brewery.name, year: @brewery.year } }
    end

    assert_redirected_to brewery_url(Brewery.last)
  end

  test "should show brewery" do
    get brewery_url(@brewery)
    assert_response :success
  end

  test "should get edit" do
    get edit_brewery_url(@brewery)
    assert_response :success
  end

  test "should update brewery" do
    patch brewery_url(@brewery), params: { brewery: { name: @brewery.name, year: @brewery.year } }
    assert_redirected_to brewery_url(@brewery)
  end

  test "should destroy brewery" do
    assert_difference("Brewery.count", -1) do
      delete brewery_url(@brewery)
    end

    assert_redirected_to breweries_url
  end
end
