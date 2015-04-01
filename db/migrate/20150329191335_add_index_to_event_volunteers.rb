class AddIndexToEventVolunteers < ActiveRecord::Migration
  def change
    add_index :event_volunteers, :volunteer_id
    add_index :event_volunteers, :event_id
    add_index :event_volunteers, [:volunteer_id, :event_id], unique: true
  end
end
