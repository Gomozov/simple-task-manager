class ProjectsController < ApplicationController

before_filter :login_required
before_filter :authorized_user, :only => [:edit, :update, :destroy]

def new
  @project = Project.new
  @title = "Sign up"
end   


def create
  @project  = current_user.projects.build(params[:project])
      if @project.save
        flash[:success] = "Project created!"
        redirect_to root_path
      else
        render 'pages/home'
      end
end

def destroy                          
  Project.find(params[:id]).destroy     
  flash[:success] = "Project destroyed."
  redirect_to current_user             
end                                  


def edit                                   
  @title = "Edit project"                     
  @project = Project.find(params[:id])           
end                                        
                                             
def update                                 
  @project = Project.find(params[:id])           
  if @project.update_attributes(params[:project])
    flash[:success] = "Project updated."   
    redirect_to @project                     
  else                                     
    @title = "Edit project"                   
    render 'edit'
  end  
end                                        

def show                        
  @project = Project.find(params[:id])    
  @title = @project.title
  @stories = @project.stories
end

private

def login_required
  unless current_user      
    flash[:info] = "Please input your login and password first."
    redirect_to signin_path
  end                                                           
end                                                                                                 

def authorized_user
  @project = current_user.projects.find_by_id(params[:id])
  redirect_to current_user if @project.nil?
end 

end
