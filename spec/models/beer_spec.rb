require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "when brewery and style are defined" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_style) { Style.new beer_type: "IPA", description: "IPA is so boring, honestly." }

    it "is not saved without a name" do
      beer = Beer.create style: test_style, brewery: test_brewery
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is saved with default style, if style is not specified" do
      beer = Beer.create name: "Humbert IPA", brewery: test_brewery
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
      expect(beer.style.beer_type).to eq("IPA")
    end

    it "is saved when name, style and brewery are defined" do
      beer = Beer.create name: "Humbert IPA", style: test_style, brewery: test_brewery
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
