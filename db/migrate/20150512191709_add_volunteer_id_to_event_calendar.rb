class AddVolunteerIdToEventCalendar < ActiveRecord::Migration
  def change
    add_column :event_calendars, :volunteer_id, :integer
  end
end
