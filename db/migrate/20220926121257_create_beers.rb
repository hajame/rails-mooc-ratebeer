class CreateBeers < ActiveRecord::Migration[7.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :style
      t.integer :brewery_id

      t.timestamps
    end
  end
end
