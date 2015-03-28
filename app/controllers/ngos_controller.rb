class NgosController < ApplicationController
  
  # only allow logged in users to access certain pages
  before_action :logged_in_ngo, only: [:edit, :update]
  # only allower owner of profile to call edit and update
  before_action :correct_ngo,   only: [:edit, :update]
  
  def index
    @ngo = Ngo.order(:name)
  end

  def show
    @ngo = Ngo.find_by(id: params[:id])
  end

  def new
    @ngo = Ngo.new
  end

  def create
    @ngo = Ngo.new(ngo_params)

    if @ngo.save
      log_in_ngo @ngo
      flash[:success] = "Welcome to your Profile Page"
      redirect_to @ngo
    else
      render 'new'
    end
  end
  
  def edit
    @ngo = Ngo.find(params[:id])
  end

  def update
    @ngo = Ngo.find(params[:id])

    if @ngo.update_attributes(ngo_params)
      flash[:success] = "Profile updated"
      redirect_to @ngo
    else
      render 'edit'
    end
  end

  #method when creating new ngo
  private
    def ngo_params
      params.require(:ngo).permit(:name, :password,
                                  :password_confirmation,                                             :location, :url, :email, :phone)
    end
  
    # test that the ngo is logged in
    def logged_in_ngo
      unless logged_in_ngo?
        store_location
        flash[:danger] = "Please log in."
        redirect_to nlogin_url
      end
    end
 
    # redirect users that are not the user currently logged in
    def correct_ngo
      @ngo = Ngo.find(params[:id])
      redirect_to(root_url) unless current_ngo?(@ngo)
    end
  
end
