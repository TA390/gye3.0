class AddResetToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :reset_digest, :string
    add_column :ngos, :reset_sent_at, :datetime
  end
end
