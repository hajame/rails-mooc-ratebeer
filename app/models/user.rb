class User < ApplicationRecord
  has_secure_password

  validates :username,
            uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  validates :password,
            length: { minimum: 4 },
            format: { with: /(.*[A-Z].*\d.*)|(.*\d.*[A-Z].*)/,
                      message: "must include at least one capital letter (A-Z) and one number (0-9)." }

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  include RatingAverage

  def self.top(limit)
    User.includes(:ratings).all
        .sort_by { |u| -u.ratings.length }
        .take(limit)
  end

  def not_member_of
    BeerClub.where.not(id: memberships.map(&:beer_club_id)).to_a
  end

  def applied_clubs
    BeerClub.where(id: memberships.where(confirmed: false).map(&:beer_club_id)).to_a
  end

  def confirmed_clubs
    BeerClub.where(id: memberships.where(confirmed: true).map(&:beer_club_id)).to_a
  end

  # @param [BeerClub] beer_club
  def member?(beer_club)
    true unless not_member_of.include?(beer_club)
  end

  def favorite_beer
    if ratings.empty?
      return nil
    end

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_beer_in_memory
    if ratings.empty?
      return nil
    end

    ratings.max_by(&:score).beer
  end

  def favorite_style
    favourite(:style)
  end

  def favorite_brewery
    favourite(:brewery)
  end

  def favourite(grouped_by)
    return nil if ratings.empty?

    grouped_ratings = ratings.group_by { |r| r.beer.send(grouped_by) }
    averages = grouped_ratings.map do |group, ratings|
      { group:, score: average_of(ratings) }
    end

    averages.max_by { |r| r[:score] }[:group]
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end
end
