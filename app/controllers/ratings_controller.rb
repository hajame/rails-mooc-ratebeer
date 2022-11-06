class RatingsController < ApplicationController
  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    rating = Rating.create params.require(:rating).permit(:beer_id, :score)
    rating.user = current_user
    rating.save
    redirect_to current_user
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end
