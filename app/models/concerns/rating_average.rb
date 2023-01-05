module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_count = ratings.size
    return 0 if rating_count == 0

    ratings.map(&:score).sum / rating_count.to_f
  end
end
