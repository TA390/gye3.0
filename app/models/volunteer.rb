class Volunteer < ActiveRecord::Base
  
  #calendar entries
  has_many :event_calendars, dependent: :destroy

  # sign up to an event
  has_many :event_volunteers, dependent: :destroy
  has_many :events, through: :event_volunteers
  
  has_many :volunteer_tags
  has_many :tags, through: :volunteer_tags
  has_many :posts

  # enter all emails into the db in a lowercase format
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  # profile picture
  has_attached_file :avatar, 
    styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" },
    default_url: "profile/default_profile.png"
  validates_attachment_content_type :avatar, 
                                    content_type: /\Aimage\/.*\Z/
  
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }


  
    # Returns count of sign ups to events
  def signups
    return self.event_volunteers.count()
  end
  
  # Returns count of sign ups to events in the future
  def future_signups
    return self.event_volunteers.joins( :event).where("start > ?", DateTime.now).count()
    #method below return same as above (for reference)
    #return Event.where("start > ?", DateTime.now).joins( :volunteers).where(volunteers: {:id => self.id} ).count()
  end
  
  # Returns count of sign ups to events in the past
  def past_signups
    return self.event_volunteers.joins( :event).where("start < ?", DateTime.now).count()
  end
  
  def future_signups_list
    return Event.where("start > ?", DateTime.now).joins( :volunteers).where(volunteers: {:id => self.id} )
  end
  
  def past_signups_list
    return Event.where("start < ?", DateTime.now).joins( :volunteers).where(volunteers: {:id => self.id} )
  end
  
 
  
  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end

      validates :name, 
        presence: true,
        length: {maximum: 254}
  
      validates :last_name, 
        presence: true,
        length: {maximum: 254}
  
      validates :gender, 
        presence: true

      validates :email,
        presence: true,
        length: {maximum: 254},
        uniqueness: { case_sensitive: false },
        email_format: {}
  
      validates :location, 
        presence: true

      # password security
      has_secure_password

      # their profile (i.e they don't have to enter a new password)
      validates :password,
        # allow blank will only apply to profile updates
        allow_blank: true,
        presence: true,
        length: { minimum: 6, maximum: 254 }
  

  class << self
    # Function to return the hash digest of 'string'
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ?
               BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    # Function to generate a token to allow users to stay signed in
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  # Function to remember a user in the database for persistent sessions
  def remember
    self.remember_token = Volunteer.new_token
    update_attribute(:remember_digest,
                     Volunteer.digest(remember_token))
  end
  
  # Function returns true if the token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Function to forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Function to activate an account, setting the values in the db
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # Function to send an activation email
  def send_activation_email
    VolunteerMailer.account_activation(self).deliver_now
  end
  
  # password reset
  def create_reset_digest
    self.reset_token = Volunteer.new_token
    update_attribute(:reset_digest, Volunteer.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # sends password reset email
  def send_password_reset_email
    VolunteerMailer.password_reset(self).deliver_now
  end
  
  # Function to test and return true if a password reset has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # Sign up to an event.
  def sign_up(event)
    event_volunteers.create(event_id: event.id, attending: true)
  end
  
  # Opt out of an event you were signed up to
  def opt_out(event)
    event_volunteers.find_by(event_id: event.id).destroy
  end
  
  # Review an event you were signed up to
  def review_event(event,score)
    #ensure signed up is true and event is in past
    if self.past_signups_list.include? (event)
      ev = event_volunteers.find_by(event_id: event.id)
      ev.update(event_score: score)
   end
  end
  
  # Average score for volunteer (from event_volunteers table)
  def volunteer_avg_score
  	return self.event_volunteers.average(:volunteer_score)
  end
  
  
  # Function to test and return true if volunteer is signed up to 'event'
  def signed_up?(event)
    (events.include?(event)) && 
      (self.event_volunteers.where(event_id: event.id, attending: true).present?) 
  end
  
  # Watch an event
  def watch(event)
    event_volunteers.create(event_id: event.id, attending: false)
  end
  
  # Stop watching an event
  def unwatch(event)
    event_volunteers.find_by(event_id: event.id).destroy
  end
  
  # Function to test if an event is being watched'
  def watching?(event)
    (events.include?(event)) && 
      (self.event_volunteers.where(event_id: event.id, attending: false).present?)
  end
  
  private
  
    # converts email to lowercase
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Volunteer.new_token
      self.activation_digest = Volunteer.digest(activation_token)
    end
  

  
end