require 'rails_helper'

include Helpers

describe "User page" do
  let!(:user) { FactoryBot.create :user }

  describe "when user has signed up signed up" do
    it "can signin with right credentials" do
      sign_in username: "Pekka", password: "Foobar1"

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content "Username and/or password mismatch"
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in 'user_username', with: 'Brian'
      fill_in 'user_password', with: 'Secret55'
      fill_in 'user_password_confirmation', with: 'Secret55'

      expect {
        click_button('Create User')
      }.to change { User.count }.by(1)
    end

    describe "when navigating on a User page" do
      it "Sees only ratings done by that user, and no one else" do
        beer1 = FactoryBot.create :beer, name: "iso 3"
        beer2 = FactoryBot.create :beer, name: "Karhu"
        user2 = FactoryBot.create :user, username: "Angela"
        FactoryBot.create :rating, user: user, beer: beer1, score: 5
        FactoryBot.create :rating, user: user2, beer: beer2, score: 10

        visit user_path(user)
        expect(page).to have_content "iso 3 5"
        expect(page).not_to have_content "Karhu 10"

        visit user_path(user2)
        expect(page).to have_content "Karhu 10"
        expect(page).not_to have_content "iso 3 5"
      end
    end
  end
end