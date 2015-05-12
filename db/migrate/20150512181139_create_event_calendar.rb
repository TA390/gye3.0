class CreateEventCalendar < ActiveRecord::Migration
   def self.up
     create_table :event_calendars do |t|
      t.string   :title
      t.datetime :start
      t.datetime :end
      t.string   :color
      t.string   :url

      t.timestamps
    end
  end

  def self.down
    drop_table :event_calendars
  end
end
