class CommentsController < ApplicationController

def new
    @comment = Comment.new
end


def create
    @comment = Comment.new (params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @comment.story.project        
    else
      render root_path
    end
end

end