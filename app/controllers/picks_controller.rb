class PicksController < ApplicationController
  def index
    @awards = Award.includes(:picks => [:player, :user]).all
    @players = Player.all
    @rookies = Player.where(DRAFT_YEAR: "2017").or(Player.where(DISPLAY_FIRST_LAST: "Ben Simmons"))
    @mvp = Award.includes(:picks => [:player, :user]).where(name: "MVP").order("player.mvp_rank asc")
    @player_count = Player.count

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
    @teams = Team.all
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


end
