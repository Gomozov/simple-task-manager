class CommentsController < ApplicationController
before_filter :login_required

def new
    @comment = Comment.new
    @story = Story.find(params[:story_id])
end


def create
    @comment = Comment.new (params[:comment])
    @comment.user = current_user
    @story = Story.find(params[:comment][:story_id])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @comment.story.project        
    else
      render 'new'
    end
end

end
