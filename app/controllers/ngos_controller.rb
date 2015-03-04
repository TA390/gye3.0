class NgosController < ApplicationController
  def index
    @ngo = Ngo.all
  end

  def show
    @ngo = Ngo.find(params[:id])
  end

  def new
    @ngo = Ngo.new
  end

  def create
    @ngo = Ngo.new(ngo_params)

    if @ngo.save
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

    if @ngo.update(ngo_params)
      redirect_to @ngo
    else
      render 'edit'
    end
  end

  #method when creating new ngo
  private
  def ngo_params
    params.require(:ngo).permit(:name, :password, :location, :url, :email, :phone)
  end
 
end
