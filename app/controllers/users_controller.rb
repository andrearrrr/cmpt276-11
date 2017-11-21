class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
  #adding some logic for friends pages (only need this if mutual friends list is not private?)
                                         :friends]
  #adding some logic for friends pages
	before_action :correct_user,   only: [:edit, :update, :outgoing_friends, :incoming_friends]
	before_action :admin_user,     only: :destroy

	def index

    #Only show activated users
    @users = User.where(activated: true).paginate(page: params[:page])

		#removed the restriction on index page to admin users only
		#if !is_admin?
		#	flash[:danger] = "Access restricted to admins"
		#	redirect_to root_path
		#end

	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
    #Line below might not work/might be weird???
    #redirect_to root_url and return unless User.where(activated: true)

    #disabling private profile for iteration 2 (Bryce)
    #if !(is_admin? || current_user == @user)
			#flash[:danger] = "Access restricted"
			#redirect_to root_path
		#end

	end

	def create
		@user = User.new(user_params)
		if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
		User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

  def outgoing_friends
    @title  = "Outgoing Friends"
    @user   = User.find(params[:id])
    @users  = @user.following.paginate(page: params[:page])
    render 'show_friends'
  end

  def incoming_friends
    @title  = "Incoming Friends"
    @user   = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:page])
    render 'show_friends'
  end

  def friends
    @title  = "Friends"
    @user   = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page]) & @user.followers.paginate(page: params[:page])
    render 'show_mutualfriends'
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

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end
