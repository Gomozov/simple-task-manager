class RelationshipsController < ApplicationController
before_filter :login_required

 def create
  @user = User.find(params[:relationship][:member_id]) 
  @project = Project.find(params[:relationship][:work_id])
  @project.member!(@user)
  redirect_to @project
 end

 def destroy
   @user = Relationship.find(params[:id]).member
   @project = Project.find(params[:relationship][:work_id])
   @project.unmember!(@user)
   redirect_to @project
 end

end
