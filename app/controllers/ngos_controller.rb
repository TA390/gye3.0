class NgosController < ApplicationController
  
  # only allow logged in users to access certain pages
  before_action :logged_in_ngo, only: [:edit, :update]
  # only allower owner of profile to call edit and update
  before_action :correct_ngo,   only: [:edit, :update]
  
  def index
    # SET ACTIVATED TO true FOR PRODUCTION
    @ngos = Ngo.paginate(page: params[:page], 
      per_page: 10).where(activated: false).order(:name)
  end

  def show
    @ngo = Ngo.find(params[:id])
    @event = Event.new
    
    redirect_to root_url and return unless @ngo
  end

  def new
    @ngo = Ngo.new
  end

  def create
    @ngo = Ngo.new(ngo_params)

    if @ngo.save
      @ngo.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
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
      params.require(:ngo).permit(:name, :password, :password_confirmation, 
                                  :location, :url, :email, :phone,
                                  :picture, :avatar)
    end
 
    # redirect users that are not the user currently logged in
    def correct_ngo
      @ngo = Ngo.find(params[:id])
      redirect_to(root_url) unless current_ngo?(@ngo)
    end
  
end