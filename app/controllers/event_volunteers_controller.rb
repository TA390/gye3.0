class EventVolunteersController < ApplicationController
  
  
  def create 
    
    @event = Event.find(params[:event_id])
    @attend = params[:attending]
    
    if @event.past?
      flash[:notice] = "Sorry but the event has passed"
      return
    end

    
    if @attend == "false"
      current_user.watch(@event) if !current_user.watching?(@event)
      flash[:success] = "The event #{@event.name} has been added to your watchlist"
    else  
      if @event.full?
        flash[:warning] = "Sorry the event is full"
      else
        # remove watched entry before adding the attend entry
        current_user.opt_out(@event) if current_user.watching?(@event)
        current_user.sign_up(@event) if !current_user.signed_up?(@event)
        
        flash[:success] = "Thank you for joining our event. We have sent you a confirmation email with the event details"
        #EventSignupMailer.event_signup(current_user, @event).deliver_now        
      end
    end
    
    
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end


  end

  def destroy
    @event = EventVolunteer.find(params[:id]).event
    @attend = params[:attending]
    
    if current_user.signed_up?(@event)
    
      current_user.opt_out(@event)

      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end

      flash[:success] = "You are no longer subscribed to #{@event.name}"
      #EventSignupMailer.event_optout(current_user, @event).deliver_now
      
    else
      current_user.unwatch(@event)
      flash[:success] = "The event #{@event.name} has been removed from your watchlist"
    end

  end
  
  def update    
    @event = EventVolunteer.find(params[:id]).event
    @attend = params[:attending]
    
    current_user.opt_out(@event) 
    
    if @attend == "true"    
      flash[:success] = "You are no longer subscribed to #{@event.name}"
    else   
      flash[:success] = "The event #{@event.name} has been removed from your watchlist"
    end
    
    redirect_to :back
  end
  
  private
    def event_volunteer_params
      params.require(:event_volunteer).permit(:volunteer_id, :event_id, :attending)
    end
  
  
end
