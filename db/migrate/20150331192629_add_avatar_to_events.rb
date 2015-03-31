class AddAvatarToEvents < ActiveRecord::Migration
  def self.up
    add_attachment :events, :avatar
  end

  def self.down
    remove_attachment :events, :avatar
  end
end
