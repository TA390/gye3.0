class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "event_tags", "events", name: "event_tags_event_id_fk"
    add_foreign_key "event_tags", "tags", name: "event_tags_tag_id_fk"
    add_foreign_key "event_volunteers", "events", name: "event_volunteers_event_id_fk"
    add_foreign_key "event_volunteers", "volunteers", name: "event_volunteers_volunteer_id_fk"
    add_foreign_key "events", "ngos", name: "events_ngo_id_fk"
    add_foreign_key "posts", "volunteers", name: "posts_volunteer_id_fk"
    add_foreign_key "posts", "walls", name: "posts_wall_id_fk"
    add_foreign_key "volunteer_tags", "tags", name: "volunteer_tags_tag_id_fk"
    add_foreign_key "volunteer_tags", "volunteers", name: "volunteer_tags_volunteer_id_fk"
  end
end
