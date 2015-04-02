class Watchlist < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer
  
  validates :event_id, 
    presence: true
  
  validates :volunteer_id, 
    presence: true
end
