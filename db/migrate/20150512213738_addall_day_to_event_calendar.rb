class AddallDayToEventCalendar < ActiveRecord::Migration
  def change
    add_column :event_calendars, :allDay, :boolean, default: false
  end
end
