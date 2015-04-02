class RemoveWalls < ActiveRecord::Migration
  def up
    add_column :posts, :event_id, :integer, null: false
  end
  
  def down
    remove_column :posts, :wall_id
    remove_foreign_key :posts, :walls
    remove_foreign_key :walls, :events
    drop_table :walls
  end
  
end
