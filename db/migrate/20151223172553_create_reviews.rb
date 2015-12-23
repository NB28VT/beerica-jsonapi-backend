class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.string :title
      t.integer :brewery_id

      t.timestamps null: false
    end
  end
end
