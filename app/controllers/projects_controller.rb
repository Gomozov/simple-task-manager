class ProjectsController < ApplicationController

before_filter :login_required

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
end

private

def login_required
  unless current_user      
    flash[:info] = "Please input your login and password first."
    redirect_to signin_path
  end                                                           
end                                                             


end
