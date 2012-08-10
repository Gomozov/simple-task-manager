class ProjectsController < ApplicationController
before_filter :authorized_user, :only => [:edit, :update, :destroy, :members]

def members
  @project = Project.find(params[:id])
  @members = @project.members
  @title = "Members"
end

def new
  @project = Project.new
  @title = "New project"
end   


def create
  @project  = current_user.projects.build(params[:project])
      if @project.save
        flash[:success] = "Project created!"
        redirect_to root_path
      else
        render 'new'
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
    redirect_to @project.user                     
  else                                     
    @title = "Edit project"                   
    render 'edit'
  end  
end                                        

def show                        
  @project = Project.find(params[:id])    
  @title = @project.title
  if params[:user]
    @done = @project.stories.where(:state => "finished", :responsible => params[:user])
    @backlog = @project.stories.where(:state => "rejected", :responsible => params[:user])
    @icebox = @project.stories.where(:state => "not_yet_started", :responsible => params[:user])
    @current = @project.stories.where(:state => ["started", "accepted", "delivered"], :responsible => params[:user])
  else
    @done = @project.stories.where(:state => "finished")
    @backlog = @project.stories.where(:state => "rejected")
    @icebox = @project.stories.where(:state => "not_yet_started")
    @current = @project.stories.where(:state => ["started", "accepted", "delivered"])
  end  
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
