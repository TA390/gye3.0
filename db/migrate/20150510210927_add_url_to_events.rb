class AddUrlToEvents < ActiveRecord::Migration
  def up
    add_column :events, :url, :string
  end
  
  def down
    remove_column :events, :url, :string
  end
end
