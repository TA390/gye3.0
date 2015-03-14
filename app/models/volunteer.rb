class Volunteer < ActiveRecord::Base

  has_many :event_volunteers
  has_many :events, through: :event_volunteers
  has_many :volunteer_tags
  has_many :tags, through: :volunteer_tags
  has_many :posts
  
  # enter all emails into the db in a lowercase format
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  
  # To allow inheritance
  def self.type
    %w(User Ngo)
  end

  scope :users, -> { where(type: 'User') } 
  scope :ngos, -> { where(type: 'Ngo') } 
  
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Volunteer.model_name
      end
    end
    super
  end
  # end of inheritance
  
  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end

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


class User < Volunteer; end 
class Ngo < Volunteer; end
