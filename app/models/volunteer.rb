class Volunteer < ActiveRecord::Base
  has_many :events, through: :event_volunteers
  has_many :volunteer_tags
  has_many :tags, through: :volunteer_tags
  
  attr_accessor :remember_token
  # enter all emails into the db in a lowercase format
  before_save { email.downcase! }
  
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
    email_format: { message: "Error: Please enter a valid email address" }
  
  validates :gender, 
    presence: true
  
  validates :location, 
    presence: true

  # password security
  has_secure_password
  
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
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Function to forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
