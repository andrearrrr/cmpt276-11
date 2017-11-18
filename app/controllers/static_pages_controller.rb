#StaticPagesController inherits from ApplicationController
class StaticPagesController < ApplicationController

#these actions are functions/methods
  def home
  	# Defien variable to use in micropost form
    @micropost = current_user.microposts.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end

end
