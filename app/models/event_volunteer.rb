class EventVolunteer < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer
  
  validate :ensure_not_full
  
  validates :event_id, 
    presence: true
  
  validates :volunteer_id, 
    presence: true
  
  def ensure_not_full
    errors.add(:event, "Sorry this event is full") if event.full?
  end

  
end
