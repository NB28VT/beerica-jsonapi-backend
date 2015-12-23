class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :brewery_id
      t.string :abv

      t.timestamps null: false
    end
  end
end
