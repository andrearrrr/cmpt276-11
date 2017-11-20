class PicksController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :correct_user,   only: [:edit, :update, :destory, :create]
  before_action :admin_user,     only: [:edit, :update, :destory]

  def index
    @picks = Pick.all
    @awards = Award.all
  end

  def show
    @pick = Pick.find_by(id: params[:id])
    if @pick.nil?
      flash[:danger] = "Pick does not exist"
  		redirect_to picks_path
    elsif (@pick.is_private) &&  (@pick.user_id != current_user.id)
      flash[:danger] = "Pick is private - Access restricted"
  		redirect_to picks_path
    end
  end

  def new
    @pick = Pick.new
    @players = Player.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pick }
      format.js
    end
  end

  def create
    pick_params[:season] = current_season
		@pick = Pick.new(pick_params)
    if logged_in?
  		if @pick.save
  			flash[:success] = "Pick submitted!"
  			redirect_to pick_path(@pick)
  		else
  			render 'new'
  		end
    else
      redirect_to picks_path, :notice => "You must be logged in to make a pick"
    end
	end

  def destroy
    @pick = Pick.find(params[:id])
    @pick.destroy
    redirect_to user_path(current_user), :notice => "Pick successfully deleted."
  end

  def edit
    @pick = Pick.find(params[:id])
  end

  def update
    @pick = Pick.find(params[:id])
    if @pick.update(pick_params)
      redirect_to pick_path(@pick), :notice => "Pick successfully updated."
    else
      render "edit"
    end
  end

  private
  def pick_params
    params.require(:pick).permit(:award_id, :player_id, :user_id, :league_id, :is_private, :season)
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
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
	end

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
