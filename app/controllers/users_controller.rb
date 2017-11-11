class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]

	def index
		if !is_admin?
			flash[:danger] = "Access restricted to admins"
			redirect_to root_path
		end
		@users = User.all
		# implicit render 'users/index'
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		if !(is_admin? || current_user == @user)
			flash[:danger] = "Access restricted"
			redirect_to root_path
		end

	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to MySportsPicks!"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path, :notice => "User successfully deleted."
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	# Before filters

	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	# Confirms the correct user.
	def correct_user
		@user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
	end

end
