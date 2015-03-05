class Volunteer < ActiveRecord::Base
  
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
