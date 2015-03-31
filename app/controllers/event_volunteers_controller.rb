class EventVolunteersController < ApplicationController
  
  
  def create
    @event = Event.find(params[:event_id])
    current_user.sign_up(@event)
 
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
    
    flash[:success] = "Thank you for joining our event"
    
  end

  def destroy
    @event = EventVolunteer.find(params[:id]).event
    current_user.opt_out(@event)
    
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
    
    flash[:success] = "You are no longer subscribed to #{@event.name}"
    
  end
  
end
