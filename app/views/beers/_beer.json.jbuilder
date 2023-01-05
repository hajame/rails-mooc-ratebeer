json.extract! beer, :id, :name, :created_at, :updated_at
json.style do
  json.beer_type beer.style.beer_type
end
json.brewery do
  json.name beer.brewery.name
end
