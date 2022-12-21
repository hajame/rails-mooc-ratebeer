class Brewery < ApplicationRecord
  include RatingAverage # module mixin

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validate :year_cannot_be_in_future
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  private

  def year_cannot_be_in_future
    return unless year.present? && year > Date.today.year

    errors.add(:year, "cannot be in the future")
  end
end
