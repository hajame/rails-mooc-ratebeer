require 'rails_helper'

include Helpers

describe "Beers page" do
  let!(:brewery) { FactoryBot.create :brewery }

  before :each do
    FactoryBot.create :user
    sign_in username: "Pekka", password: "Foobar1"
    visit beers_path
  end

  describe "when new beer is created" do
    before :each do
      click_link "New beer"
    end

    it "creates a valid beer when valid name is given" do
      fill_in 'beer_name', with: 'SuperBeer'
      select('Lager', from: 'beer_style')
      select('anonymous', from: 'beer_brewery_id')

      expect {
        click_button "Create Beer"
      }.to change { Beer.count }.from(0).to(1)
      expect(brewery.beers.count).to eq(1)
      expect(brewery.beers.first.name).to eq('SuperBeer')
      expect(page).to have_content "Beer was successfully created."
    end

    it "does not create a beer when empty name is given" do
      fill_in 'beer_name', with: ''
      select('Lager', from: 'beer_style')
      select('anonymous', from: 'beer_brewery_id')
      click_button "Create Beer"

      expect(Beer.count).to eq(0)
      expect(brewery.beers.count).to eq(0)
      expect(page).to have_content "Name can't be blank"
    end
  end

end
