class CreateEventVolunteers < ActiveRecord::Migration
  def change
    create_table :event_volunteers do |t|
      t.integer :volunteer_id, null: false
      t.integer :event_id, null: false
      t.timestamps null: false
    end
  end
end
