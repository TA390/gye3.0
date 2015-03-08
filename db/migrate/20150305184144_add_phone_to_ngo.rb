class AddPhoneToNgo < ActiveRecord::Migration
  def change
    remove_column :ngos, :phone_number
    add_column :ngos, :phone_number, :string
  end
end
