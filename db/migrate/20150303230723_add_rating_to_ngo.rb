class AddRatingToNgo < ActiveRecord::Migration
  def change
    add_column :ngos, :rating, :float
  end
end
