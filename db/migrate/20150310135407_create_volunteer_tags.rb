class CreateVolunteerTags < ActiveRecord::Migration
  def change
    create_table :volunteer_tags do |t|

      t.timestamps null: false
    end
  end
end
