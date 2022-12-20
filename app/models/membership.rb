class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club
end
