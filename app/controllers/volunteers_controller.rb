class VolunteersController < ApplicationController
  
  
  before_action :logged_in_user, only: [:edit, :update, :events]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    if params[:tags].present? && params[:location].present?
      #joins vol table to tags (via volunteer_tag) on tag name matching param tags and location
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE location = (?) 
        AND id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY name", 
        params[:location],params[:tags],params[:tags].size])
      
    elsif params[:tags].present?
      #joins vol table to tags (via volunteer_tag) on tag name matching param tags
      @volunteers = Volunteer.find_by_sql(
        ["SELECT * FROM volunteers
        WHERE id IN 
          (SELECT vt.volunteer_id 
          FROM volunteer_tags vt 
          INNER JOIN tags t ON vt.tag_id = t.id 
          WHERE t.name IN (?) 
          GROUP BY vt.volunteer_id 
          HAVING COUNT(*) = ?)
        ORDER BY name", 
        params[:tags],params[:tags].size])
      
    elsif params[:event_id].present?
      #joins vol table to events (via event_volunteer) on event id matching param event_id
      @volunteers = Volunteer.joins( :events).where(events: {:id => params[:event_id]} ).order(:name)
      
    elsif params[:location].present?
      #shows all vols with location matching params location
      @volunteers = Volunteer.where(:location => params[:location]).order(:name)
      
    else
      #show all
      # SET ACTIVATED TO true FOR PRODUCTION
      @volunteers = Volunteer.paginate(page: params[:page], 
        per_page: 10).order(:name).where(activated: false).order(:name)
    end
   
  end
      

  def show
      @user = Volunteer.find(params[:id])
      redirect_to root_url and return unless @user
  end
  
  def new
    @user = Volunteer.new
  end
  
  def create
  
    @user = Volunteer.new(user_params)
      
    if @user.save
      @user.send_activation_email
      flash[:notice] = "Please check your email to activate your account"
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
  
  def events
    @title = "My Events"
    @user  = Volunteer.find(params[:id])
    @events = @user.events.paginate(page: params[:page], per_page: 10)
  end


  # private functions
  private
  
    def user_params
      params.require(:volunteer).permit(:name, :last_name, :email,
                                        :location, :gender, :password, 
                                        :password_confirmation, :picture,
                                        :avatar)  
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
