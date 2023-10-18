class SessionsController < ApplicationController
  #skip_before_action :authorize

  def new
  end 

  def create 
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # session[:user_id] = user.id 
      login user
      redirect_to root_path, :notice => "logged in"
    else
      #flash[:alert] = "Invalid email or password"
      flash.now.alert = "something wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out"
  end
end