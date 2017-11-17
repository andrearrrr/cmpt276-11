class PicksController < ApplicationController
  def index
    @picks = Pick.all
  end

  def show
    @pick = Pick.find(params[:id])
  end

  def new
    @pick = Pick.new
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
    redirect_to picks_path, :notice => "Pick successfully deleted."
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
