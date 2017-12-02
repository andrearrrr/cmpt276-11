require 'json'
class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @stats = parse_stats(@player.PERSON_ID.to_s)

  end

  private

  def parse_stats(p_id)
    url = "http://stats.nba.com/stats/playercareerstats?PlayerID=" + p_id + "&LeagueID=00&PerMode=PerGame"
    #url = "http://stats.nba.com/stats/playerprofilev2?PerMode=PerGame&PlayerID=" + p_id
  #  url = "http://stats.nba.com/stats/playergamelog?PlayerID=" + p_id + "&LeagueID=00&Season=2017-18&SeasonType=Regular%20Season"
    headers = {"Accept-Language": "en-us","User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38","Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 'referer': 'http://stats.nba.com/'}
    resp = RestClient.get(url, headers = headers)
    JSON.parse(resp)
  end

end
