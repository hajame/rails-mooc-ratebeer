class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :style

  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true

  include RatingAverage

  def self.top(limit)
    Beer.all.sort_by { |b| -b.average_rating }.take(limit)
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
