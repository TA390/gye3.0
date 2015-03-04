class CreateNgos < ActiveRecord::Migration
  def change
    create_table :ngos do |t|
      t.string :name
      t.string :password
      t.string :location
      t.string :url
      t.string :email
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
