class RatingsCacheJob
  include SuckerPunch::Job

  # Decided not to start configuring SuckerPunch.
  def perform
    puts "START: updating Ratings page cache"
    Rails.cache.write("recent_ratings", Rating.recent)
    Rails.cache.write("top_beers", Beer.top(3))
    Rails.cache.write("top_styles", Style.top(3))
    Rails.cache.write("top_breweries", Brewery.top(3))
    Rails.cache.write("top_users", User.top(3))
    RatingsCacheJob.perform_in(15.minutes)
    puts "DONE: updating Ratings page cache"
  end
end
