class VolunteersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
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
