class AddActivityToBrewery < ActiveRecord::Migration[7.0]
  def change
    add_column :breweries, :active, :boolean
  end
end
