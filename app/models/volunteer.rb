class Volunteer < ActiveRecord::Base
  has_many :events, through: :event_volunteers
  
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


end
