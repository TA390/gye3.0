class AddAvatarToVolunteers < ActiveRecord::Migration
  def self.up
    add_attachment :volunteers, :avatar
  end

  def self.down
    remove_attachment :volunteers, :avatar
  end
end
