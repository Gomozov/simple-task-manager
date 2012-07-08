class SessionsController < ApplicationController

def new
  @title = "Sign in"
end

def create
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Log in."
    redirect_to root_url
  else
    flash[:error] = "Invalid email or password"
    render "new"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url
end

end
