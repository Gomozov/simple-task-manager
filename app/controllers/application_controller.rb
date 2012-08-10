class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required                                              
    unless current_user                                           
      flash[:info] = "Please input your login and password first."
      redirect_to signin_path                                     
    end                                                           
  end

  helper_method :current_user

end
