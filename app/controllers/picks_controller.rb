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
		if @pick.save
			flash[:success] = "Pick submitted!"
			redirect_to pick_path(@pick)
		else
			render 'new'
		end
	end

  private
  def pick_params
    params.require(:pick).permit(:award_id, :player_id, :user_id, :league_id, :is_private)
  end
end
