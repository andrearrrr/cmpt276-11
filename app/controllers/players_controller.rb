class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
    @line_chart = get_trends(@player)

  end

  private

  def get_trends(player)
    seasons = []
    per = []
    points = []
    rebounds = []
    assists = []

    player.player_stats.order(season: :asc).each do |stat|
      seasons << stat.season
      per << stat.per
      points << stat.points
      rebounds << stat.rebtot
      assists << stat.assists
    end

    line_chart = Gchart.line(
              :title => "Statistical Trends",
              :legend => ["PER", 'Points', 'Rebounds', 'Assists'],
              :data => [per, points, rebounds, assists],
              :axis_with_label => 'x',
              :axis_labels => [seasons])
    return line_chart
  end
end
