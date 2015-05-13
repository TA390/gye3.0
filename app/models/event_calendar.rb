class EventCalendar < ActiveRecord::Base
  belongs_to :volunteer
  
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :start => self.start,
      :end => self.end,
      :color => self.color,
      :url => self.url,
      :allDay => self.allDay,
     }
  end
  
end