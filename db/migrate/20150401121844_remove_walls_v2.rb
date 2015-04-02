class RemoveWallsV2 < ActiveRecord::Migration
  def change
    remove_column :posts, :wall_id
    remove_foreign_key :walls, :events
    drop_table :walls
  end
end
