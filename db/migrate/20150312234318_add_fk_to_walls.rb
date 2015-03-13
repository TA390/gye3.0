class AddFkToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :event_id, :integer
    add_foreign_key "walls", "events", name: "wall_event_event_id_fk"
  end
end