require "test_helper"

class BeerClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beer_club = beer_clubs(:one)
  end

  test "should get index" do
    get beer_clubs_url
    assert_response :success
  end

  test "should get new" do
    get new_beer_club_url
    assert_response :success
  end

  test "should create beer_club" do
    assert_difference("BeerClub.count") do
      post beer_clubs_url, params: { beer_club: { city: @beer_club.city, founded: @beer_club.founded, name: @beer_club.name } }
    end

    assert_redirected_to beer_club_url(BeerClub.last)
  end

  test "should show beer_club" do
    get beer_club_url(@beer_club)
    assert_response :success
  end

  test "should get edit" do
    get edit_beer_club_url(@beer_club)
    assert_response :success
  end

  test "should update beer_club" do
    patch beer_club_url(@beer_club), params: { beer_club: { city: @beer_club.city, founded: @beer_club.founded, name: @beer_club.name } }
    assert_redirected_to beer_club_url(@beer_club)
  end

  test "should destroy beer_club" do
    assert_difference("BeerClub.count", -1) do
      delete beer_club_url(@beer_club)
    end

    assert_redirected_to beer_clubs_url
  end
end
