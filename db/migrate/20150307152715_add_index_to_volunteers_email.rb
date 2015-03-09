class AddIndexToVolunteersEmail < ActiveRecord::Migration
  def change
    add_index :volunteers, :email, unique: true
  end
end
