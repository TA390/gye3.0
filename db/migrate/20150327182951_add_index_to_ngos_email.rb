class AddIndexToNgosEmail < ActiveRecord::Migration
  def change
    add_index :ngos, :email, unique: true
  end
end
