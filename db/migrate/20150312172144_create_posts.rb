class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :volunteer_id, null: false
      t.integer :wall_id, null: false
      t.text :comment, null: false
      t.timestamps null: false
    end
  end
end
