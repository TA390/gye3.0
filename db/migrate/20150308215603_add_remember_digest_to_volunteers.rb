class AddRememberDigestToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :remember_digest, :string
  end
end
