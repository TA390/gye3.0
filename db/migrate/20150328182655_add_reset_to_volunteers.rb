class AddResetToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :reset_digest, :string
    add_column :volunteers, :reset_sent_at, :datetime
  end
end
