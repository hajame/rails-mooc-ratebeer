# b1 = Brewery.create name: "Koff", year: 1897
# b2 = Brewery.create name: "Malmgard", year: 2001
# b3 = Brewery.create name: "Weihenstephaner", year: 1040
#
# b1.beers.create name: "Iso 3", style: "Lager"
# b1.beers.create name: "Karhu", style: "Lager"
# b1.beers.create name: "Tuplahumala", style: "Lager"
# b2.beers.create name: "Huvila Pale Ale", style: "Pale Ale"
# b2.beers.create name: "X Porter", style: "Porter"
# b3.beers.create name: "Hefeweizen", style: "Weizen"
# b3.beers.create name: "Helles", style: "Lager"

# Data for performance tuning
users = 50
breweries = 50
beers_in_brewery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create! username: "user_#{i}", password: "Passwd1", password_confirmation: "Passwd1"
end

(1..breweries).each do |i|
  Brewery.create! name: "Brewery_#{i}", year: 1900, active: true
end

bulk = Style.create! beer_type: "Bulk", description: "cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create! name: "Beer #{b.id} -- #{i}", style: bulk, brewery: b
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new score: (1 + rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end