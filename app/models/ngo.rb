class Ngo < ActiveRecord::Base
  has_many :events, dependent: :destroy
  
    validates :ngo_id,
      presence: true
  
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
end
