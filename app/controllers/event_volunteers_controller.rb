class EventVolunteersController < ApplicationController
  
  
  def create
    event = Event.find(params[:event_id])
    current_user.sign_up(event)
    
    redirect_to event
  end

  def destroy
    event = EventVolunteer.find(params[:id]).event
    current_user.opt_out(event)
    
    flash[:success] = "You are no longer subscribed to the event"
    redirect_to :back
  end
  
end
