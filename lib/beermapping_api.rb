class BeermappingApi
  def self.places_in(city)
    url = "https://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    locations = response.parsed_response["bmp_locations"]["location"]

    return [] if locations.is_a?(Hash) && locations["id"].nil?

    locations = [locations] if locations.is_a?(Hash)
    locations.map do |place|
      Place.new(place)
    end
  end

  def self.key
    "145afef662199ad3da4151b5326e66f2"
  end
end
