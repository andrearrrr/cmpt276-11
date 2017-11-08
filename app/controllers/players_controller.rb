class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
    @line_chart = Gchart.line(:data => [0, 40, 10, 70, 20])
  end
end
