class DropTableUsers < ActiveRecord::Migration
  def up
    #drop_table :users
  end
  
  def down
    create_table :users do |t|
      t.string :last_name
      t.string :gender

      t.timestamps null: false
    end
  end
end
