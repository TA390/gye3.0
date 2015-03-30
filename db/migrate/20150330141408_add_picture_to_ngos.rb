class AddPictureToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :picture, :string
  end
end
