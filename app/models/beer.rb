class Beer < ApplicationRecord
  extend Rateable
  belongs_to :brewery, touch: true
  belongs_to :style, touch: true

  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true

  include RatingAverage

  def to_s
    "#{name}, #{brewery.name}"
  end
end
