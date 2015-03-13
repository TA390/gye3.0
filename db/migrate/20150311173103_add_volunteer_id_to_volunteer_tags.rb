class AddVolunteerIdToVolunteerTags < ActiveRecord::Migration
  def change
    add_column :volunteer_tags, :volunteer_id, :integer
  end
end
