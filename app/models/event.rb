class Event < ActiveRecord::Base
  has_many :event_tags
  has_many :tags, through: :event_tags
end
