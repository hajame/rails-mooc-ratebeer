class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { get_places_in(city) }
  end

  def self.get_places_in(city)
    url = "https://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    locations = response.parsed_response["bmp_locations"]["location"]

    return [] if locations.is_a?(Hash) && locations["id"].nil?

    locations = [locations] if locations.is_a?(Hash)
    locations.map do |place|
      Place.new(place)
    end
  end

  def self.get_place(_place_id)
    Rails.cache.fetch("helsinki")[0]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'BEERMAPPING_APIKEY env variable not defined' if ENV['BEERMAPPING_APIKEY'].nil?

    ENV.fetch('BEERMAPPING_APIKEY')
  end
end
