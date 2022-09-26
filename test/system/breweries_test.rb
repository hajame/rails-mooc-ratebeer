require "application_system_test_case"

class BreweriesTest < ApplicationSystemTestCase
  setup do
    @brewery = breweries(:one)
  end

  test "visiting the index" do
    visit breweries_url
    assert_selector "h1", text: "Breweries"
  end

  test "should create brewery" do
    visit breweries_url
    click_on "New brewery"

    fill_in "Name", with: @brewery.name
    fill_in "Year", with: @brewery.year
    click_on "Create Brewery"

    assert_text "Brewery was successfully created"
    click_on "Back"
  end

  test "should update Brewery" do
    visit brewery_url(@brewery)
    click_on "Edit this brewery", match: :first

    fill_in "Name", with: @brewery.name
    fill_in "Year", with: @brewery.year
    click_on "Update Brewery"

    assert_text "Brewery was successfully updated"
    click_on "Back"
  end

  test "should destroy Brewery" do
    visit brewery_url(@brewery)
    click_on "Destroy this brewery", match: :first

    assert_text "Brewery was successfully destroyed"
  end
end
