class Event < ActiveRecord::Base
  belongs_to :ngo
  has_many :event_tags
  has_many :tags, through: :event_tags
  has_many :event_volunteers
  has_many :volunteers, through: :event_volunteers
  has_one :wall, dependent: :destroy 
  
  # Checks to see if event is full (occupancy==signups)
  def full?
    self.event_volunteers.count() == self.occupancy
  end
  
#   def full
#     capacity = self.EventVolunteers.count
#     if self.occupancy == capacity
#       return true
#       # errors.add(:occupancy, "Sorry this event is full")
#     end
#   end

end