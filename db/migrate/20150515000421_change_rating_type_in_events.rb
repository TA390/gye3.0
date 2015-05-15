class ChangeRatingTypeInEvents < ActiveRecord::Migration
    def self.up
      change_table :events do |t|
        t.change :rating, :integer
      end
    end
end
