json.extract! brewery, :id, :name, :year, :active, :created_at, :updated_at
json.beers do
  json.count brewery.beers.size
end
