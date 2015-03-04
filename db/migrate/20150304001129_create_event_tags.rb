class CreateEventTags < ActiveRecord::Migration
  def change
    create_table :event_tags do |t|
      t.integer :tag_id, null: false
      t.integer :event_id, null: false
      t.timestamps null: false
    end
  end
end
