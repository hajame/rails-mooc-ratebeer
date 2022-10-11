class RatingsController < ApplicationController
  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end
end