class EventCalendarsController < ApplicationController
  
  def index
    @cal  = current_user.event_calendars
    render json: @cal.to_json
  end
  
  def create
    if logged_in?
      @entry  = current_user.event_calendars.build(calendar_params)
    end
    
    if @entry.save
      flash.now[:success] = "New Calendar Entry Created!"      
    end
    
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
    
  end
  
  
  private
  
  def calendar_params
    params.require(:event_calendar).permit(:title, :start, :end, :color, :url)
  end
  
end