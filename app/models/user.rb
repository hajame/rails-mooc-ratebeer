class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,
            uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
            format: { with: /(.*[A-Z].*\d.*)|(.*\d.*[A-Z].*)/,
                      message: "must include at least one capital letter (A-Z) and one number (0-9)." }

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  def not_member_of
    BeerClub.where.not(id: memberships.map(&:beer_club_id))
  end
end
