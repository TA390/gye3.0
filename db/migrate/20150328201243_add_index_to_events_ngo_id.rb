class AddIndexToEventsNgoId < ActiveRecord::Migration
  def change
    add_index :events, [:ngo_id, :created_at]
  end
end
