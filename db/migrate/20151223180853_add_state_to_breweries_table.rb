class AddStateToBreweriesTable < ActiveRecord::Migration
  def change
    remove_column :breweries, :state
    add_column :breweries, :state_id, :integer
  end
end
