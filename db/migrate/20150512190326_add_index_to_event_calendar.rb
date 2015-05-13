class AddIndexToEventCalendar < ActiveRecord::Migration
  def change
    add_column :event_calendars, :volunteer_id, :integer
    add_index  :event_calendars, :volunteer_id
    add_index  :event_calendars, [:volunteer_id], unique: true
  end
end
