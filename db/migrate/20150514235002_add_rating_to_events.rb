class AddRatingToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :rating, :decimal, :precision => 2, :scale => 1
  end
  
  def self.down
    remove_column :events, :rating, :decimal, :precision => 2, :scale => 1
  end
end
