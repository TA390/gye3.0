class Post < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer
end
