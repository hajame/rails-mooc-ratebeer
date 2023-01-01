class Style < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include RatingAverage

  def self.top(limit)
    Style.all.sort_by { |s| -s.average_rating }.take(limit)
  end
end
