class RemoveNgoId < ActiveRecord::Migration
  def change
    remove_column :ngos, :ngo_id
  end
end
