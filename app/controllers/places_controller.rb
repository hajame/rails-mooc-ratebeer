class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "145afef662199ad3da4151b5326e66f2"
    url = "https://beermapping.com/webservice/loccity/#{api_key}/"
    response = HTTParty.get "#{url}#{params[:city]}"
    locations = response.parsed_response["bmp_locations"]["location"]

    if locations.is_a?(Hash) && locations["id"].nil?
      redirect_to places_path, notice: "No places in #{params[:city]}."
    else
      @places = locations.map do |place|
        Place.new(place)
      end
      render :index, status: 418
    end
  end
end
