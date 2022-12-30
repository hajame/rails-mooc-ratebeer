class SetDefaultBeerStyle < ActiveRecord::Migration[7.0]
  def up
    Beer.connection.execute("UPDATE beers SET style_id = 1 WHERE style_id IS NULL")
  end

  def down
    Beer.connection.execute("UPDATE beers SET style_id = NULL WHERE style_id = 1")
  end
end
