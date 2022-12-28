class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "145afef662199ad3da4151b5326e66f2"
    url = "https://beermapping.com/webservice/loccity/#{api_key}/"

    response = HTTParty.get "#{url}helsinki"
    places_from_api = response.parsed_response["bmp_locations"]["location"]
    @places = [Place.new(places_from_api.first)]

    render :index, status: 418
  end
end
