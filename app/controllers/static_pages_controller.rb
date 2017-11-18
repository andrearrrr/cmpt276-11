#StaticPagesController inherits from ApplicationController
class StaticPagesController < ApplicationController

#these actions are functions/methods
  def home
  	# Define variables to use in micropost form
    if logged_in?
      # Define variable to use in micropost form
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end

  end

  def help
  end

  def about
  end

  def contact
  end

end
