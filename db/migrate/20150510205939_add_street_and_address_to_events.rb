class AddStreetAndAddressToEvents < ActiveRecord::Migration
  def up
    add_column :events, :street, :string
    add_column :events, :address, :string
  end
  
  def down
    remove_column :events, :street, :string
    remove_column :events, :address, :string
  end
end
