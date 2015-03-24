class AddNgoId < ActiveRecord::Migration
  def change
    add_column :ngos, :ngo_id, :integer
  end
end
