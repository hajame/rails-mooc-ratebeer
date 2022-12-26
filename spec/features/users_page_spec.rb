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

      save_and_open_page
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
  end
end