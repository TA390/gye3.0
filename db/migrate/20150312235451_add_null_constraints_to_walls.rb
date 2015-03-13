class AddNullConstraintsToWalls < ActiveRecord::Migration
  def change
    change_column :walls, :event_id, :integer, null: false
  end
end
