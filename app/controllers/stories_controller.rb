class StoriesController < ApplicationController

 def new                                                    
   @story = Story.new                                   
   @title = "Create story"
 end                                                        
                                                             
                                                             
 def create                                                 
   @story = Story.new (params[:story])
   @story.user = current_user
   if @story.save                                     
     flash[:success] = "Story created!"               
     redirect_to @story.project                              
   else                                                 
     render root_path                               
   end                                                  
 end                                                        

 def update                 
   @story = Story.find(params[:id])
   if @story.update_attributes(params[:story])
     redirect_to @story.project
   else                                 
     render @story.project
   end  
 end                        

 def change_state
   @story = Story.find(params[:id])
   @story.send"#{params[:new_state]}!"
   redirect_to @story.project
 end

end
