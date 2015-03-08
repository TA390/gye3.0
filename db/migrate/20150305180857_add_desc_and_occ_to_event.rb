class AddDescAndOccToEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :occupancy, :integer
  end
end
