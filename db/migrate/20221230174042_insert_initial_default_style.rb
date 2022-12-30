class InsertInitialDefaultStyle < ActiveRecord::Migration[7.0]
  def up
    execute "INSERT INTO styles (beer_type, description, created_at, updated_at) VALUES ('Lager', 'Lager (/ˈlɑːɡər/) is beer which has been brewed and conditioned at low temperature. Lagers can be pale, amber, or dark. Pale lager is the most widely consumed and commercially available style of beer. The term \"lager\" comes from the German for \"storage\", as the beer was stored before drinking, traditionally in the same cool caves in which it was fermented. As well as maturation in cold storage, most lagers are distinguished by the use of Saccharomyces pastorianus, a \"bottom-fermenting\" yeast that ferments at relatively cold temperatures.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
  end

  def down
    execute "DELETE FROM styles WHERE beer_type = 'Lager'"
  end
end
