class User < ApplicationRecord
  include RatingAverage

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

  def not_member_of
    BeerClub.where.not(id: memberships.map(&:beer_club_id))
  end

  def favorite_beer
    if ratings.empty?
      return nil
    end

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    if ratings.empty?
      return nil
    end

    style_with_top_avg_score
  end

  def favorite_brewery
    if ratings.empty?
      return nil
    end

    ratings.first.beer.brewery.name
  end

  private

  def style_with_top_avg_score
    scores_map = scores_by_styles
    top = 0
    result = nil
    scores_map.sort.each do |style, scores|
      avg = scores.sum / scores.length
      if top < avg
        top = avg
        result = style
      end
    end
    result
  end

  def scores_by_styles
    result = {}
    ratings.each do |r|
      result[r.beer.style] = [] unless result.key?(r.beer.style)
      result[r.beer.style].push(r.score)
    end
    result
  end
end
