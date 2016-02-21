class AddImagesToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :medium_label, :string
    add_column :beers, :large_labe, :string
    add_column :beers, :icon, :string
  end
end
