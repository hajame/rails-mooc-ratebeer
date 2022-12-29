require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name: "Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if two is returned by the API, both are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("sörkkä").and_return(
      [Place.new(name: "Hokkuspokkus", id: 1), Place.new(name: "Vein Rahas", id: 2)]
    )

    visit places_path
    fill_in('city', with: 'sörkkä')
    click_button "Search"
    expect(page).to have_content "Hokkuspokkus"
    expect(page).to have_content "Vein Rahas"
  end

  it "no results returned by the API, show notification" do
    allow(BeermappingApi).to receive(:places_in).with("vehtoo").and_return([])

    visit places_path
    fill_in('city', with: 'vehtoo')
    click_button "Search"
    expect(page).to have_content "No places in vehtoo."
  end
end
