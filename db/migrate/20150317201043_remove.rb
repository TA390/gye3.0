class Remove < ActiveRecord::Migration
  def change
    remove_column :events, :signups
  end
end
