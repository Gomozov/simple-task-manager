class RelationshipsController < ApplicationController
before_filter :login_required

 def create
  @user = User.find(params[:relationship][:member_id]) 
  @project = Project.find(params[:relationship][:work_id])
  @project.member!(@user)
  redirect_to current_user
 end

 def destroy
   @user = Relationship.find(params[:id]).member
   @project = Project.find(params[:relationship][:work_id])
   @project.unmember!(@user)
   redirect_to current_user
 end

private

def login_required                                              
  unless current_user                                           
    flash[:info] = "Please input your login and password first."
    redirect_to signin_path                                     
  end                                                           
end                                                             

end
