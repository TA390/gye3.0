class AddColumnAttendingToEventVolunteers < ActiveRecord::Migration
  def change
    add_column :event_volunteers, :attending, :boolean, default: true
  end
end
