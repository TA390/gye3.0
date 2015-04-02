class WatchlistsController < ApplicationController
  
  
  def create
    
    @event = Event.find(params[:event_id])
    
    if params[:attending] == "false"
      current_user.watch(@event)
      return
    end
    
    if @event.full?
      flash.now[:warning] = "Sorry the event is the full"
    else
      current_user.sign_up(@event)

      flash[:success] = "The event #{@event.name} has been added to your watchlist"
      
      respond_to do |format|
        format.html { redirect_to @event }
        format.js
      end

    end
  end

  def destroy
    @event = Watchlist.find(params[:id]).event
    current_user.opt_out(@event)
    
    flash[:success] = "The event #{@event.name} has been removed from your watchlist"
    
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end

  end
  
  def update    
    @event = Watchlist.find(params[:id]).event
    current_user.opt_out(@event)
    
    flash[:success] = "You are no longer watching the event #{@event.name}"

    redirect_to :back

  end
  
end