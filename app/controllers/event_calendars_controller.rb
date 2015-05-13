class EventCalendarsController < ApplicationController
  
  def index
    @cal  = current_user.event_calendars
    render json: @cal.to_json
  end
  
  def create
    if logged_in?
      @entry  = current_user.event_calendars.build(calendar_params)
      render json: @cal
    end
    
    if @event.save
      flash[:success] = "New Calendar Entry Created!"
      redirect_to volunteers_path(current_user)
    else
      render 'volunteers/show'
    end
    
    
  end
  
  
  private
  
  def calendar_params
    params.require(:event).permit(:id, :title, :start, :end, :color, :url, :volunteer_id)
  end
  
end