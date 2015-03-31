class Event < ActiveRecord::Base
  belongs_to :ngo
  default_scope -> { order(created_at: :desc) }
  
  # profile picture
  has_attached_file :avatar, 
    styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" },
    default_url: "event/default_event.png"
  validates_attachment_content_type :avatar, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }
  
  has_many :event_tags
  has_many :tags, through: :event_tags
  has_many :event_volunteers, dependent: :destroy
  has_many :volunteers, through: :event_volunteers
  has_one :wall, dependent: :destroy 
  
  validate :event_date
  
  validates :ngo_id, 
    presence: true
  
  validates :name, 
    presence: true
  
  validates :start, 
    presence: true

  validates :end, 
    presence: true

  validates :location, 
    presence: true
  
  validates :description, 
    presence: true, 
    length: { maximum: 1000 }
  
  validates :occupancy, 
    numericality: { greater_than_or_equal_to: 1 }

  
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
  
  private
    def event_date
      if past?
        valid = false
        errors.add(:start, "date cannot be in the past")
      end  

      if self.end < self.start
        errors.add(:end, "date cannot be before start date")
      elsif self.end < ::DateTime.current
        errors.add(:end, "date cannot be in the past")
      end       
    end
  
  
#   def full
#     capacity = self.EventVolunteers.count
#     if self.occupancy == capacity
#       return true
#       # errors.add(:occupancy, "Sorry this event is full")
#     end
#   end

end