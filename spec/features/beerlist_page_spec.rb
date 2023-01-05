require 'rails_helper'

describe "Beerlist page" do
  before :all do
    setup_test_with_js
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create beer_type: "Lager"
    @style2 = Style.create beer_type: "Rauchbier"
    @style3 = Style.create beer_type: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  it "shows two known beers", js: true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
    expect(page).to have_content "Fastenbier"
  end

  it "shows beers in alphabetical order by default", js: true do
    visit beerlist_path
    rows = find('#beertable').find_all('.tablerow')

    expect(rows[0]).to have_content "Fastenbier Rauchbier Schlenkerla"
    expect(rows[1]).to have_content "Lechte Weisse Weizen Ayinger"
    expect(rows[2]).to have_content "Nikolai Lager Koff"
  end
end

def setup_test_with_js
  Capybara.register_driver :firefox do |app|
    options = Selenium::WebDriver::Firefox::Options.new
    options.headless!
    options.add_argument("--disable-gpu") # doesn't seem to do anything on firefox
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  end
  Capybara.javascript_driver = :firefox
  WebMock.allow_net_connect! allow_localhost: true
end