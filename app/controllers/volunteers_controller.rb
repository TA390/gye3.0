class VolunteersController < ApplicationController
  
  def show
    @user = Volunteer.find(params[:id])
  end
  
  def new
    @user = Volunteer.new
  end
  
  def create
    @user = Volunteer.new(user_params)    
    if @user.save
      flash[:success] = "Welcome to your profile"
      redirect_to @user
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
