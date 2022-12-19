require "application_system_test_case"

class BeerClubsTest < ApplicationSystemTestCase
  setup do
    @beer_club = beer_clubs(:one)
  end

  test "visiting the index" do
    visit beer_clubs_url
    assert_selector "h1", text: "Beer clubs"
  end

  test "should create beer club" do
    visit beer_clubs_url
    click_on "New beer club"

    fill_in "City", with: @beer_club.city
    fill_in "Founded", with: @beer_club.founded
    fill_in "Name", with: @beer_club.name
    click_on "Create Beer club"

    assert_text "Beer club was successfully created"
    click_on "Back"
  end

  test "should update Beer club" do
    visit beer_club_url(@beer_club)
    click_on "Edit this beer club", match: :first

    fill_in "City", with: @beer_club.city
    fill_in "Founded", with: @beer_club.founded
    fill_in "Name", with: @beer_club.name
    click_on "Update Beer club"

    assert_text "Beer club was successfully updated"
    click_on "Back"
  end

  test "should destroy Beer club" do
    visit beer_club_url(@beer_club)
    click_on "Destroy this beer club", match: :first

    assert_text "Beer club was successfully destroyed"
  end
end
