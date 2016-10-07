class RemoveUniqueBandId < ActiveRecord::Migration[5.0]
  def change
    remove_index :albums, :band_id
    add_index :albums, :band_id
  end
end
