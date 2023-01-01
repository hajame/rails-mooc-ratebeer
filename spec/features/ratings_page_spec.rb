require 'rails_helper'

include Helpers

describe "Ratings page" do
  let!(:brewery) { FactoryBot.create :brewery }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in username: "Pekka", password: "Foobar1"
  end

  it "contains a list of recent ratings and top raters" do
    FactoryBot.create :rating, user: user, beer: beer1
    FactoryBot.create :rating, user: user, beer: beer2

    visit ratings_path

    expect(page).to have_content "Pekka 2 ratings"
    expect(page).to have_content "#{beer1.name} 10 Pekka"
    expect(page).to have_content "#{beer2.name} 10 Pekka"
  end

  describe "New rating" do
    it "when created, is registered to the beer and user who is signed in" do
      visit new_rating_path
      select('iso 3', from: 'rating[beer_id]')
      fill_in 'rating[score]', with: '15'

      expect {
        click_button "Create Rating"
      }.to change { Rating.count }.from(0).to(1)

      expect(user.ratings.count).to eq(1)
      expect(beer1.ratings.count).to eq(1)
      expect(beer1.average_rating).to eq(15.0)
    end
  end
end
