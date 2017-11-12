require 'json'

class PlayersController < ApplicationController
  def index
    @players = Player.all
    @leagues = League.all
    @awards = Award.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def test
    @result = JSON.parse(`python lib/assets/python/nba.py`)
  end

  private

end
