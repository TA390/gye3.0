class Event < ActiveRecord::Base
  belongs_to :ngo
  has_many :event_tags
  has_many :tags, through: :event_tags
  has_many :event_volunteers
  has_many :volunteers, through: :event_volunteers
  has_one :wall, dependent: :destroy
end
