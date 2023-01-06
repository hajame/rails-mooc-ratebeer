class Beer < ApplicationRecord
  belongs_to :brewery, touch: true
  belongs_to :style, touch: true

  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true

  include RatingAverage

  def self.top(limit)
    Beer.all.sort_by { |b| -b.average_rating }.take(limit)
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
