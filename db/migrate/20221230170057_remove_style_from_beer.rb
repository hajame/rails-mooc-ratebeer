class RemoveStyleFromBeer < ActiveRecord::Migration[7.0]
  def change
    remove_column :beers, :style, :string
  end
end
