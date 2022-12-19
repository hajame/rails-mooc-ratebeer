class User < ApplicationRecord
  include RatingAverage

  validates :username,
            uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  has_many :ratings
  has_many :beers, through: :ratings
end
