class AddTagIdToVolunteerTags < ActiveRecord::Migration
  def change
    add_column :volunteer_tags, :tag_id, :integer
  end
end
