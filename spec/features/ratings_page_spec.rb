require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    visit signin_path
    fill_in 'username', with: 'Pekka'
    fill_in 'password', with: 'Foobar1'
    click_button 'Log in'
  end

  it "when given, is registered to the beer and user who is signed in" do
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