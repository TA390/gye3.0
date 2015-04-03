class AddBioToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :bio, :text
  end
end
