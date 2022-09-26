require "application_system_test_case"

class BeersTest < ApplicationSystemTestCase
  setup do
    @beer = beers(:one)
  end

  test "visiting the index" do
    visit beers_url
    assert_selector "h1", text: "Beers"
  end

  test "should create beer" do
    visit beers_url
    click_on "New beer"

    fill_in "Brewery", with: @beer.brewery_id
    fill_in "Name", with: @beer.name
    fill_in "Style", with: @beer.style
    click_on "Create Beer"

    assert_text "Beer was successfully created"
    click_on "Back"
  end

  test "should update Beer" do
    visit beer_url(@beer)
    click_on "Edit this beer", match: :first

    fill_in "Brewery", with: @beer.brewery_id
    fill_in "Name", with: @beer.name
    fill_in "Style", with: @beer.style
    click_on "Update Beer"

    assert_text "Beer was successfully updated"
    click_on "Back"
  end

  test "should destroy Beer" do
    visit beer_url(@beer)
    click_on "Destroy this beer", match: :first

    assert_text "Beer was successfully destroyed"
  end
end
