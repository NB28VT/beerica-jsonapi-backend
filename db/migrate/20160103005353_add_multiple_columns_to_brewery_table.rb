class AddMultipleColumnsToBreweryTable < ActiveRecord::Migration
  def change
    add_column :breweries, :city, :string
    add_column :breweries, :postal_code, :string
    add_column :breweries, :latitude, :string
    add_column :breweries, :longitude, :string

    # Boolean:
    add_column :breweries, :open_to_public, :boolean

    add_column :breweries, :description, :string
    add_column :breweries, :website, :string
    add_column :breweries, :established, :string

    # Images

    add_column :breweries, :icon_image, :string
    add_column :breweries, :medium_image, :string
    add_column :breweries, :large_image, :string
    add_column :breweries, :square_medium_image, :string
    add_column :breweries, :square_large_image, :string
  end
end
