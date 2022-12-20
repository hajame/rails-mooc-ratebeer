class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,
            uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 }

  has_many :ratings
  has_many :memberships
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  def not_member_of
    BeerClub.where.not(id: memberships.map(&:beer_club_id))
  end
end
