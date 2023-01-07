class RatingsController < ApplicationController
  before_action :invalidate_list_caches, except: %i[index new]

  # GET /ratings or /ratings.json.
  #
  # Decided not to go async, instead updating the cache every once in a while.
  # Users triggering the cache update will experience a long page delay.
  # Also added eager loading to *.top(amount) methods and Rating.recent, removing n+1 SQL queries.
  def index
    # delay is purposefully set low to help with assessment and testing.
    delay = 2.minutes
    @recent = Rails.cache.fetch("recent_ratings", expires_in: delay) { Rating.recent }
    @top_beers = Rails.cache.fetch("top_beers", expires_in: delay) { Beer.top(3) }
    @top_styles = Rails.cache.fetch("top_styles", expires_in: delay) { Style.top(3) }
    @top_breweries = Rails.cache.fetch("top_breweries", expires_in: delay) { Brewery.top(3) }
    @top_users = Rails.cache.fetch("top_users", expires_in: delay) { User.top(3) }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:beer_id, :score)
    @rating.user = current_user

    if @rating.save
      redirect_to current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
