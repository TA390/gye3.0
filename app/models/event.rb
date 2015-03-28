class Event < ActiveRecord::Base
  belongs_to :ngo
  has_many :event_tags
  has_many :tags, through: :event_tags
  has_many :event_volunteers
  has_many :volunteers, through: :event_volunteers
  has_one :wall, dependent: :destroy 

  
  # Checks to see if event is full (occupancy==count of event_volunteers)
  # Returns true if count is greater or equal to occupancy (does not block)
  def full?
    self.event_volunteers.count() >= self.occupancy
  end
  
  # Returns count of sign ups to event
  def signups
    return self.event_volunteers.count()
  end

  # Returns true for an an event in the future
  def future?
    self.start > ::DateTime.current
  end
  
  # Returns true for an event in the past
  def past?
    self.start < ::DateTime.current
  end
  
  scope :upcoming, -> { where(future: true) }
  

#   def full
#     capacity = self.EventVolunteers.count
#     if self.occupancy == capacity
#       return true
#       # errors.add(:occupancy, "Sorry this event is full")
#     end
#   end

end