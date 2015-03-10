class Tag < ActiveRecord::Base
  has_many :event_tags
  has_many :events, through: :event_tags
  has_many :volunteer_tags
  has_many :volunteers, through: :volunteer_tags
end
