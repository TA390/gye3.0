class User < Volunteer #ActiveRecord::Base
      
  
  validates :last_name, 
    presence: true,
    length: {maximum: 254}
  
  validates :gender, 
    presence: true
  
end
