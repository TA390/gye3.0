class AddTypeToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :type, :string
  end
end
