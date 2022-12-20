class BeerClub < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
