class UsersController < ApplicationController
  
  before_filter :login_required, :only => [:index, :edit, :update]
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Simple Task Manager"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit              
    @title = "Edit user"
  end                   

  def update                                 
    @user = User.find(params[:id])           
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."   
      redirect_to @user                      
    else                                     
      @title = "Edit user"              
      render 'edit'                          
    end             
  end

  def index                                                             
    @title = "All users"                                                
    @users = User.all
  end                                                                   

  private

  def login_required
    unless current_user
      flash[:info] = "Please input your login and password first."
      redirect_to signin_path
    end
  end

end
