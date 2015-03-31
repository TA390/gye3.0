class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.integer :event_id
      t.integer :volunteer_id

      t.timestamps null: false
    end
    add_index :watchlists, :event_id
    add_index :watchlists, :volunteer_id
    add_index :watchlists, [:event_id, :volunteer_id], unique: true
  end
end
