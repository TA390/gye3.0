class RenameColumnFirstNameInVolunteer < ActiveRecord::Migration
  def change
    rename_column :volunteers, :first_name, :name
  end
end
