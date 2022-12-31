class WeatherApi
  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch("#{city}_weather", expires_in: 1.hour) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    res = response.parsed_response
    wind_ms = res["current"]["wind_speed"].to_i * 1000 / 3600
    Weather.new location: res["location"]["name"],
                temperature: res["current"]["temperature"],
                icon_urls: res["current"]["weather_icons"],
                wind_speed: wind_ms,
                wind_dir: res["current"]["wind_dir"]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'BEERWEATHER_APIKEY env variable not defined' if ENV['BEERWEATHER_APIKEY'].nil?

    ENV.fetch('BEERWEATHER_APIKEY')
  end
end
