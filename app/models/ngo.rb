class Ngo < ActiveRecord::Base
  
  has_many :events, dependent: :destroy
  
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
  
  # converts email to lowercase
  def downcase_email
    self.email = email.downcase
  end

  validates :name,
    presence: true,
    length: { minimum: 2 }
    
  validates :password,
    # allow blank will only apply to profile updates
    allow_blank: true,
    presence: true,
    length: { minimum: 6, maximum: 254 }
  #validates :location, length: { minimum: 2 }
  #validates :click_through_url, url: true  
  validates :email,
    presence: true,
    length: {maximum: 254},
    uniqueness: { case_sensitive: false },
    email_format: { message: "Error: Please enter a valid email address" }
    #uniqueness: true { message: "Error: Email already in use" }
  #validates :bio, length: { maximum: 500 }
  #validates :terms_of_service, acceptance: true
  
  # password security
  has_secure_password
  
  
  
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
    self.remember_token = Ngo.new_token
    update_attribute(:remember_digest,
                     Ngo.digest(remember_token))
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
  
  # sends an activation email.
  def send_activation_email
    NgoMailer.account_activation(self).deliver_now
  end
  
  # password reset
  def create_reset_digest
    self.reset_token = Ngo.new_token
    update_attribute(:reset_digest, Ngo.digest(reset_token))
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
  
  
  # Review a volunteer who attended your event
  def review_volunteer(volunteer,event,score)
    if self.events.include? (event.id) && event.past? && logged_in_ngo?
      ev = event_volunteers.find_by_volunteer_id_and_event_id(volunteer.id, event.id)
      ev.update(volunteer_score: score)
    end
   end
  
#   # Review a vol that signed up to event
#   def review_volunteer(volunteer,event,score)
#     #ensure signed up is true and event is in past
#     if volunteer.past_signups_list.include? (event) && self.events.include? (event)
#       ev = event_volunteers.find_by(event_id: event.id)
#       ev.update(volunteer_score: score)
#     end
#   end
  
  private

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Ngo.new_token
      self.activation_digest = Ngo.digest(activation_token)
    end
  
end