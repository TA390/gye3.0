class AddLogoAndContactAndVideoAndCnameAndCemailAndPostcodeToEvents < ActiveRecord::Migration
  def up
    add_column :events, :postcode, :string
  end
  
  def down
    remove_column :events, :postcode, :string
  end
end
