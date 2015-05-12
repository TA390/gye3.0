class AddScoresToEventVolunteers < ActiveRecord::Migration
  def change  
    add_column :event_volunteers, :volunteer_score, :integer
    add_column :event_volunteers, :event_score, :integer

  end
end
