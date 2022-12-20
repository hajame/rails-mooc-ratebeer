class UniqueMembership < ActiveRecord::Migration[7.0]
  def change
    add_index :memberships, [:beer_club_id, :user_id], unique: true
  end
end
