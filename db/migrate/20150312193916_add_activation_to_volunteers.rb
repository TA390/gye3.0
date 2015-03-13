class AddActivationToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :activation_digest, :string
    add_column :volunteers, :activated, :boolean, default: false
    add_column :volunteers, :activated_at, :datetime
  end
end
