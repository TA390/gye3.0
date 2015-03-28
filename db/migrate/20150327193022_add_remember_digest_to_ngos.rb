class AddRememberDigestToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :remember_digest, :string
  end
end
