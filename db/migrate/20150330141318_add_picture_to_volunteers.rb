class AddPictureToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :picture, :string
  end
end
