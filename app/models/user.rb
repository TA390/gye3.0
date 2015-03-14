class User < Volunteer #ActiveRecord::Base
      
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
  
  validates :last_name, 
    presence: true,
    length: {maximum: 254}
  
  validates :gender, 
    presence: true
  
  # password security
  has_secure_password

  # their profile (i.e they don't have to enter a new password)
  validates :password,
    presence: true,
    length: { minimum: 6, maximum: 254 }
  
end
