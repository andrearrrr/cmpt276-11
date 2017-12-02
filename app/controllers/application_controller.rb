class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include PicksHelper

  @awards_updated_at = nil

  private

  #Confirms an user is logged in
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
end
