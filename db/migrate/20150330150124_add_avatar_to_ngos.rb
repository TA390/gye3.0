class AddAvatarToNgos < ActiveRecord::Migration
  def self.up
    add_attachment :ngos, :avatar
  end

  def self.down
    remove_attachment :ngos, :avatar
  end
end
