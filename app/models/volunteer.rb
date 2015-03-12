class Volunteer < ActiveRecord::Base
  has_many :events, through: :event_volunteers
  has_many :volunteer_tags
  has_many :tags, through: :volunteer_tags
  
  # enter all emails into the db in a lowercase format
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  
  validates :first_name, 
    presence: true,
    length: {maximum: 254}

  validates :last_name, 
    presence: true,
    length: {maximum: 254}

  validates :email,
    presence: true,
    length: {maximum: 254},
    uniqueness: { case_sensitive: false },
    email_format: {}
  
  validates :gender, 
    presence: true
  
  validates :location, 
    presence: true

  # password security
  has_secure_password

  # 'allow_blank' will only take effect when a user is updating
  # their profile (i.e they don't have to enter a new password)
  validates :password,
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
  
  # Function to send an activation email
  def send_activation_email
    VolunteerMailer.account_activation(self).deliver_now
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
  
  # Function to activate an account, setting the values in the db
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  

  
end
