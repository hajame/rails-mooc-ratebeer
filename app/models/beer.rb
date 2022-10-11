class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        sum = ratings.map(&:score).sum
        sum.to_f / ratings.size
    end
end
