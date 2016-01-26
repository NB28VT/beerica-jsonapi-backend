class AddDescriptionAndStyleToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :description, :text
    add_column :beers, :style, :string
  end
end
