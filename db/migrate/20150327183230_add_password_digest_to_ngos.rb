class AddPasswordDigestToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :password_digest, :string
  end
end
