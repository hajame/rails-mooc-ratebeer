class BeerClub < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def applicants
    users.where(id: memberships.where(confirmed: false).map(&:user_id)).to_a
  end

  def confirmed_members
    users.where(id: memberships.where(confirmed: true).map(&:user_id)).to_a
  end

  def accept_user(user)
    membership = memberships.find_by(user_id: user.id)
    membership.confirmed = true
    membership.save
  end
end
