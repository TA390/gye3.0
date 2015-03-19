class AddUrlAndGenderAndLastNameAndPhoneToVolunteers < ActiveRecord::Migration
  def up
    #add_column :volunteers, :last_name, :string
    #add_column :volunteers, :gender, :string
    #add_column :volunteers, :phone_number, :string
    #add_column :volunteers, :url, :string
  end
  
  
  def down
    add_column :volunteers, :last_name, :string
    add_column :volunteers, :gender, :string
    add_column :volunteers, :phone_number, :string
    add_column :volunteers, :url, :string
  end
end
