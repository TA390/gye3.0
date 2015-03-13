class VolunteersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
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
    @ngo = false
    @invalid_input = false
  end
  
  def create
    @user = Volunteer.new(user_params)    
    if @user.save
      @user.send_activation_email
      flash[:info] = "We have sent you your activation email."
      redirect_to root_url
      
      #log_in(@user)
      #remember(@user)
      #flash[:success] = "Welcome to your profile"
      #redirect_to @user
    else
      @invalid_input = true
      render 'new'
    end
  end
  
  
  def edit
    @user = Volunteer.find(params[:id])
  end
  
  def update
    @user = Volunteer.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  # private functions
  private
  
    def user_params

      if params[:commit] == "Create Volunteer Account"
        flash[:danger] = "Burn"
        params.require(:volunteer).permit(:first_name, :last_name, :email,
                                          :gender, :location, :password, 
                                          :password_confirmation)
      else
        @ngo = true
        params.require(:volunteer).permit(:first_name, :email,
                                          :location, :password, 
                                          :password_confirmation)
      end
      
    end
  
    # Function to test if a user has logged in
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
  
  # Function to ensure that the profile owner is making the edits / 
  # updates
    def correct_user
      @user = Volunteer.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
end
