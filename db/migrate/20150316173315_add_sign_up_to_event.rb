class AddSignUpToEvent < ActiveRecord::Migration
  def change
    add_column :events, :signups, :integer
  end
end
