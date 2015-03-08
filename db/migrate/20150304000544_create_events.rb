class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.timestamp :start
      t.timestamp :end
      t.string :location
      t.timestamps null: false
      
      t.belongs_to :ngo, index:true
#       t.integer :ngo_id, null: false  
    end
  end
end
