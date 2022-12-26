require 'rails_helper'

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with: 'Pekka')
      fill_in('password', with: 'Foobar1')
      click_button('Log in')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with: 'Pekka')
      fill_in('password', with: 'wrong')
      click_button "Log in"

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
  end
end