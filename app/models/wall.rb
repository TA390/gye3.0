class Wall < ActiveRecord::Base
  belongs_to :event
  has_many :posts
end
