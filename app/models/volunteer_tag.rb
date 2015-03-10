class VolunteerTag < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :tag
end
