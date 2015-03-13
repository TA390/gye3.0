class Post < ActiveRecord::Base
  belongs_to :wall
  belongs_to :volunteer
end
