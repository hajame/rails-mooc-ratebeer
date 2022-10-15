class RatingsController < ApplicationController
  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
  end

  def create
    Rating.create params.require(:rating).permit(:beer_id, :score)
    redirect_to ratings_path
  end

end
