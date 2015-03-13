class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :volunteer_tags, :tag_id, :integer, null: false
    change_column :volunteer_tags, :volunteer_id, :integer, null: false

  end
end
