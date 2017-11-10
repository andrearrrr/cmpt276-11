class PlayersController < ApplicationController
  def index
    @players = Player.all
    @leagues = League.all
    @awards = Award.all
  end

  def show
    @player = Player.find(params[:id])


  end

  private

end
