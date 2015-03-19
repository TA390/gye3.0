class VolunteersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    #list all vols by loc, by tag, and by event (signed up!)
    if params[:tags].present?
      #joins vol table to tags (via volunteer_tag) on tag name matching param tags
      @volunteers = Volunteer.joins( :tags).where(tags: {:name => params[:tags]} ).order(:first_name)
    
    elsif params[:event_ids].present?
      #joins vol table to events (via event_volunteer) on event name matching param events
      @volunteers = Volunteer.joins( :events).where(events: {:id => params[:event_ids]} ).order(:first_name)
      # need to add to table, 2 columns, sign_up and basket (AND signup == true)
      
    elsif params[:location].present?
      #shows all vols with location matching params location
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
    @user = User.new
  end
  
  def create
  
    if params[:commit] == "Create Volunteer Account"
      @user = User.new(user_params)
      @created_for = "new_user"
    else
      @user = Ngo.new(user_params)
      @created_for = "new_ngo"
    end
      
    if @user.save
      @user.send_activation_email
      flash[:info] = "We have sent your activation email."
      redirect_to root_url
      
      #log_in(@user)
      #remember(@user)
      #flash[:success] = "Welcome to your profile"
      #redirect_to @user
    else
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

      params.require(:volunteer).permit(:name, :last_name, :email,
                                        :location, :gender, :password, 
                                        :password_confirmation, :type)
      
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
