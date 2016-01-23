class AddBreweryDbIdToBreweryTable < ActiveRecord::Migration
  def change
    add_column :breweries, :brewery_db_id, :string
  end
end
