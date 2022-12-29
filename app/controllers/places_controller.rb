class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No places in #{params[:city]}."
    else
      render :index, status: 418
    end
  end
end
