class ApplicationController < ActionController::Base
  include Pagy::Backend
  #before_action :authorize
  
  def authorize
    redirect_to login_url if current_user.nil?
    #if current_user
    #  redirect_to logout_url unless current_user.active?
    #end
  end

  include Pagy::Backend
  
  private
  def current_user
    #@current_user ||= authenticate_user_from_session
    @current_user ||= User.find(1)
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login(user)
    #Current.user = user
    @current_user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    #Current.user = nil
    @current_user = nil
    reset_session
  end  
end
