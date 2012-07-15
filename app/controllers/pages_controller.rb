class PagesController < ApplicationController

 def home
  if current_user
    redirect_to(user_path(current_user))
  end
  @title = "Home"
 end

 def contact
  @title = "Contact"
 end

 def about
  @title = "About"
 end

 def help
  @title = "Help" 
 end

end
