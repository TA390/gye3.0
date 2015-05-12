class EventTag < ActiveRecord::Base
  belongs_to :event
  accepts_nested_attributes_for :event
  belongs_to :tag
end
