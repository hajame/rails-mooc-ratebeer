class Style < ApplicationRecord
  extend Rateable
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include RatingAverage
end
