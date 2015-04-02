class Event < ActiveRecord::Base
  belongs_to :ngo
  has_many :posts
  #default_scope -> { order(created_at: :desc) }
  
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
  # sign up to an event
  has_many :event_volunteers, dependent: :destroy
  has_many :volunteers, through: :event_volunteers

  
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
  
    
   # for search params
   # scope :featured, -> { where(:featured => true) }
   scope :by_tag, -> tag { where(:tags.name => tag) }
   scope :by_ngo, -> ngo { where(:ngos.name => ngo) }
   scope :by_vol, -> vol { where(:volunteers.volunteer_id => vol) }
   scope :by_loc, -> location { where(:location => location) }
   scope :by_period, -> started_at, ended_at { where("start = ? AND end = ?", started_at, ended_at) }
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
  
  

end