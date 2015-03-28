class SignUpsController < ApplicationController
  def new
    @user = Volunteer.new
    @ngo  = Ngo.new
  end
end
