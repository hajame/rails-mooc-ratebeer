require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.new username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved when password is too short" do
    user = User.new username: "Pekka", password: "Se1", password_confirmation: "Se1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved when password has no digits" do
    user = User.new username: "Pekka", password: "Seeek", password_confirmation: "Seeek"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryBot.create(:user) }

    it "has method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user) { FactoryBot.create(:user) }
    it "has method for determining favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style.beer_type).to eq("Lager")
    end

    it "is the style with highest rating if several rated" do
      create_beer_with_ratings({ style: "ipa", user: user }, 4)
      create_beer_with_ratings({ style: "lager", user: user }, 10)
      create_beer_with_ratings({ style: "weiss", user: user }, 1)

      expect(user.favorite_style.beer_type).to eq("lager")
    end

    it "is the style with highest avg rating if rated several times" do
      create_beer_with_ratings({ style: "ipa", user: user }, 2, 11, 11)
      create_beer_with_ratings({ style: "weiss", user: user }, 1, 12, 14)
      create_beer_with_ratings({ style: "lager", user: user }, 10, 10, 10)

      expect(user.favorite_style.beer_type).to eq("lager")
    end
  end

  describe "favourite brewery" do
    let(:user) { FactoryBot.create(:user) }
    it "has method for determining favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated brewery if only one rating" do
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_brewery.name).to eq("anonymous")
    end

    it "is the brewery with highest rated beer if several are rated" do
      beer = create_brewrery_with_beer "Brew"
      rating_for(beer, 20)

      beer2 = create_brewrery_with_beer "ABC Brew"
      rating_for(beer2, 21)

      beer3 = create_brewrery_with_beer "DEF Brew"
      rating_for(beer3, 19)

      expect(user.favorite_brewery.name).to eq("ABC Brew")
    end

    it "is the brewery with highest avg rated beer if several are rated" do
      beer = create_brewrery_with_beer "Brew"
      rating_for(beer, 2)
      rating_for(beer, 2)
      rating_for(beer, 22)

      beer2 = create_brewrery_with_beer "ABC Brew"
      rating_for(beer2, 21)
      rating_for(beer2, 21)
      rating_for(beer2, 21)

      expect(user.favorite_brewery.name).to eq("ABC Brew")
    end

    it "is brewery with highest avg rating among ALL beers" do
      brewery = FactoryBot.create(:brewery, name: "Brew")
      beer = FactoryBot.create(:beer, brewery: brewery)
      beer2 = FactoryBot.create(:beer, brewery: brewery)
      rating_for(beer, 10)
      rating_for(beer, 10)
      rating_for(beer2, 21)
      rating_for(beer2, 21)

      brewery2 = FactoryBot.create(:brewery, name: "ABC Brew")
      beer3 = FactoryBot.create(:beer, brewery: brewery2)
      beer4 = FactoryBot.create(:beer, brewery: brewery2)
      rating_for(beer3, 20)
      rating_for(beer3, 20)
      rating_for(beer4, 20)
      rating_for(beer4, 20)

      expect(user.favorite_brewery.name).to eq("ABC Brew")
    end
  end

  def rating_for(beer, score)
    FactoryBot.create(:rating, score: score, beer: beer, user: user)
  end

  def create_brewrery_with_beer(name)
    brewery = FactoryBot.create(:brewery, name: name)
    FactoryBot.create(:beer, brewery: brewery)
  end

  def create_beer_with_rating(object, score)
    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    beer
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end

  def create_beer_with_ratings(object, *scores)
    beer = FactoryBot.create(:beer, style: create_style(object[:style]))
    scores.each do |score|
      FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    end
  end

  def create_style(name)
    FactoryBot.create(:style, beer_type: name, description: "desc")
  end

end
