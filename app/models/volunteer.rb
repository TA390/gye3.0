class Volunteer < ActiveRecord::Base
  has_many :events, through: :event_volunteers
  has_many :volunteer_tags
  has_many :tags, through: :volunteer_tags
  
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

  # Function to return the hash digest of 'string'
  def Volunteer.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
             BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
