class AddNullConstraintsToEvent < ActiveRecord::Migration
  def change
    
    change_column :events, :name, :string, null: false
    change_column :events, :start, :datetime, null: false    
    change_column :events, :end, :datetime, null: false    
    change_column :events, :location, :string, null: false
    change_column :events, :ngo_id, :integer, null: false    
    change_column :events, :description, :text, null: false    
    change_column :events, :occupancy, :integer, null: false      
    change_column :events, :signups, :integer, null: false    

  end
end
