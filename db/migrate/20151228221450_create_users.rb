class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps null: false
    end

    add_column :reviews, :user_id, :integer

  end
end
