require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "when brewery is defined" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }

    it "is not saved without a name" do
      beer = Beer.create style: "IPA", brewery: test_brewery
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "Humbert IPA", brewery: test_brewery
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is saved when name, style and brewery are defined" do
      beer = Beer.create name: "Humbert IPA", style: "IPA", brewery: test_brewery
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
