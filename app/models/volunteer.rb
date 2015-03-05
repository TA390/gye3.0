class Volunteer < ActiveRecord::Base
<<<<<<< HEAD
  has_many :events, through: :event_volunteers
  validates :email, email_format: { message: "Error: Please enter a valid email address" }
  #validates :email,
  # uniqueness: true { message: "Error: Email already in use" }
  validates :name, length: { minimum: 2 }
  validates :gender, presence: true
  #validates :password, length: { in: 6..20 }
  #validates :bio, length: { maximum: 500 }
  #validates :terms_of_service, acceptance: true
end
=======
  
    # enter all emails in a lowercase format
    before_save { self.email = email.downcase }
  
    validates :first_name, 
                presence: true,
                length: {maximum: 254}
  
    validates :last_name, 
                presence: true,
                length: {maximum: 254}
  
    validates :email, 
                presence: true,
                length: {maximum: 254},
                uniqueness: { case_sensitive: false }
end
>>>>>>> user_sign_up_v1
