class EventVolunteer < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer
  
  validates :ensure_not_full
  
  def ensure_not_full
    errors.add(:event, "sorry this event is full") if event.full?
  end
end
