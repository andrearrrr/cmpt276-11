class UsersController < ApplicationController
	def index
		@users = User.all
		# implicit render 'users/index'
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
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
		if @user.update(user_params)
			redirect_to user_path(@user), :notice => "User successfully updated."
		else
			render "edit"
		end
	end


	private
	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
