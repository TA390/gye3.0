class VolunteersController < ApplicationController
  
  def index
    #list all vols by loc, by tag, and by event (signed up!)
    
    if params[:tags].present?
      #joins vol table to tags (via volunteer_tag) on tag name matching param tags
      @volunteer = Volunteer.joins( :tags).where(tags: {:name => params[:tags]} ).order(:first_name)
    
    elsif params[:events].present?
      #joins vol table to events (via event_volunteer) on event name matching param events
      @volunteers = Volunteer.joins( :events).where(events: {:name => params[:events]} ).order(:first_name)
      # need to add to table, 2 columns, sign_up and basket (AND signup == true)
      
    elsif params[:location].present?
      #joins event table to ngos (on ngoid) matching param ngos name
      @volunteers = Volunteer.where(:location => params[:location]).order(:first_name)
      
    else
      #show all
      @volunteers = Volunteer.order(:first_name)
    end
  end
      
  def show
    @user = Volunteer.find(params[:id])
  end
  
  def new
    @user = Volunteer.new
  end
  
  def create
    user = Volunteer.new(user_params)    
    if user.save
      log_in(user)
      remember(user)
      flash[:success] = "Welcome to your profile"
      redirect_to user
    else
      render 'new'
    end
  end

  # private functions
  private
  
    def user_params
      params.require(:volunteer).permit(:first_name, :last_name, :email,
                                        :gender, :location, :password, 
                                        :password_confirmation)
    end
  
end
