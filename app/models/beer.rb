class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating

        # Counting the average with ActiveRecord::Calculations
        # =>  ratings.average(:score).to_f
        #
        # 'sum' can be calculated also with reduce:
        # =>  ratings.reduce(0) { |sum, rating| sum + rating.score }
        sum = ratings.map(&:score).sum
        sum.to_f / ratings.size
    end

    def to_s
        "#{self.name}, #{self.brewery.name}"
    end
end
