class Event < ActiveRecord::Base
  
  belongs_to :ngo
  
  has_many :posts
  #default_scope -> { order(created_at: :desc) }
  
  # event picture
  has_attached_file :avatar, 
    #styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" },
  default_url: "event/event_default.png"
  validates_attachment_content_type :avatar, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }
  
  # logo picture
  has_attached_file :logo, 
    #styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" },
  default_url: "event/event_default.png"
  validates_attachment_content_type :logo, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment :logo,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }
  
    # contact picture
  has_attached_file :contact, 
    #styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" },
  default_url: "event/event_default.png"
  validates_attachment_content_type :contact, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment :logo,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }
  
  
  has_many :event_tags, dependent: :destroy
  accepts_nested_attributes_for :event_tags, reject_if: lambda{ |a| a[:name].blank?} 
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

  validates :street,
    presence: true
  
  validates :address,
    presence: true

  validates :postcode,
    presence: true
  
  validates :location, 
    presence: true
  
  validates :description, 
    presence: true, 
    length: { maximum: 1000 }
  
  validates :occupancy, 
    numericality: { greater_than_or_equal_to: 1 }
  
  validates :cname, 
    presence: true,
    length: {maximum: 254}
  
  validates :cemail, 
    presence: true,
    length: {maximum: 254}
  
  # Checks to see if event is full (occupancy==count of event_volunteers)
  # Returns true if count is greater or equal to occupancy (does not block)
  def full?
    self.event_volunteers.where(["event_volunteers.attending = ?", "t"]).count() >= self.occupancy
  end
  
  # Returns count of sign ups to event
  def signups
    return self.event_volunteers.where(["event_volunteers.attending = ?", "t"]).count()
  end

  # Returns true for an an event in the future
  def future?
    self.start > ::DateTime.current
  end
  
  # Returns true for an event in the past
  def past?
    self.start < ::DateTime.current
  end
  
  def events_in_area(location)
    Event.where("location ~* ?", "[.]*#{location}[.]*").limit(9)
  end
    
  # average score for event (from event_volunteers table)
  def event_avg_score
  	return self.event_volunteers.average(:event_score)
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