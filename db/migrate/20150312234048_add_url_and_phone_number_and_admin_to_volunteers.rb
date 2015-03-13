class AddUrlAndPhoneNumberAndAdminToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :url, :string
    add_column :volunteers, :phone_number, :string
    add_column :volunteers, :admin, :boolean, default: false
  end
end
