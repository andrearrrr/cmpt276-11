class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_reset_email
      flash[:info] = "Please check email address to reset password"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not recognized"
      render 'new'
    end
  end

  def edit
  end
end
