class Brewery < ApplicationRecord
    include RatingAverage

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def print_report
        puts name
        puts "established at year #{year}"
        puts "number of beers #{beers.count}"
    end

    def restart
        self.year = 2022
        puts "changed year to #{year}"
    end
end
