class AddGenderAndLocationToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :location, :string
    add_column :volunteers, :gender, :string
  end
end
