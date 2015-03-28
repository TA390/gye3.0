class AddActivationToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :activation_digest, :string
    add_column :ngos, :activated, :boolean, default: false
    add_column :ngos, :activated_at, :datetime
  end
end
