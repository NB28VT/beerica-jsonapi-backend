class ChangeColumnLargeImageBeers < ActiveRecord::Migration
  def change
    rename_column :beers, :large_labe, :large_label
  end
end
