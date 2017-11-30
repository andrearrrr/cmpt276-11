class PicksController < ApplicationController
  def index
    @awards = Award.all
    @players = Player.all
    @rookies = Player.where(DRAFT_YEAR: "2017")
    @mvp = Award.includes(:picks => [:player, :user]).where(name: "MVP") .order("player.mvp_rank asc")
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

  def update_awards
    url = "http://stats.nba.com/stats/leaguedashplayerbiostats?LeagueID=00&PerMode=PerGame&Season=2017-18&SeasonType=Regular%20Season"
    data = parse_stats(url)
    update_players(JSON.parse(data))
    redirect_to picks_path, :notice => "Awards and stats updated."
  end

  private

  def pick_params
    params.require(:pick).permit(:award_id, :player_id, :user_id, :league_id, :is_private, :season)
  end

  def parse_stats(url)
    headers = {"Accept-Language": "en-us","User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38","Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 'referer': 'http://stats.nba.com/'}
    resp = RestClient.get(url, headers = headers )
  end

  def read_json(fname)
  	file = File.read(Rails.root.join('lib', 'seeds', fname))
  	return data = JSON.parse(file)
  end

  def update_players(data)
    stats = data['resultSets'][0]['rowSet']
    headers = data['resultSets'][0]['headers']
    stat_cols = ["GP","PTS","REB","AST","NET_RATING","USG_PCT","TS_PCT"]
    # loop through every player in the data set
    stats.each do |row|
      # create a hash with the player's data
      p_dict = Hash[headers.zip(row)]
      # get the player from the DB (returns nil if DNE)
      player = Player.find_by(PERSON_ID: p_dict["PLAYER_ID"])
      # if player exists, update stats
      if player
        # update each of the stat columns
        stat_cols.each do |stat|
          player[stat] = p_dict[stat]
        end
        player.save!
      end
    end
  end

end
