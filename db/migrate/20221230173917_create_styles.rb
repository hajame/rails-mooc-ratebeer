class CreateStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :styles do |t|
      t.string :beer_type
      t.text :description

      t.timestamps
    end
  end
end
