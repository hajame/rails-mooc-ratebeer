class User < ApplicationRecord
  include RatingAverage

  has_many :ratings
end
