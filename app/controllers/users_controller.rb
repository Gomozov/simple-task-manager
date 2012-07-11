class UsersController < ApplicationController
  
  before_filter :login_required, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy          
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @title = @user.name
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
    @user = User.find(params[:id])
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
    @users = User.paginate(:page => params[:user_page], :per_page => 10 )
  end

  def destroy                          
    User.find(params[:id]).destroy     
    flash[:success] = "User destroyed."
    redirect_to users_path             
  end                                  
  
  private

  def login_required
    unless current_user
      flash[:info] = "Please input your login and password first."
      redirect_to signin_path
    end
  end

  def correct_user                                     
    @user = User.find(params[:id])                     
    redirect_to(root_path) unless @user == current_user
  end                                                  
                                                       
  def admin_user                                       
    redirect_to(root_path) unless current_user.admin?  
  end                                                  

end
