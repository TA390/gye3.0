class PasswordResetsController < ApplicationController
  
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = Volunteer.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if password_blank?
      flash.now[:danger] = "Password cannot be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Success, your password has been reset"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  
  def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Test if no password has been entered
    def password_blank?
      params[:user][:password].blank?
    end

    def get_user
      @user = Volunteer.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
  
    # Check if expiration placed on reset token has expired.
    def check_expiration
      if @ngo.password_reset_expired?
        flash[:danger] = "Password reset link has expired."
        redirect_to new_password_reset_url
      end
    end
  
end
