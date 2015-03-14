class Ngo < Volunteer #ActiveRecord::Base
  
  
  has_many :events, dependent: :destroy

  validates :name, 
    presence: true,
    length: {maximum: 254}

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
    presence: true,
    length: { minimum: 6, maximum: 254 }
  
=begin
  validates :name, 
    length: { minimum: 2 }
  validates :password, 
    length: { in: 6..20 }
  #validates :location, length: { minimum: 2 }
  #validates :click_through_url, url: true  
  validates :email, 
    email_format: { message: "Error: Please enter a valid email address" }
    #uniqueness: true { message: "Error: Email already in use" }
  #validates :bio, length: { maximum: 500 }
  #validates :terms_of_service, acceptance: true
=end
  
end
