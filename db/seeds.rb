#require 'csv'
require 'json'

def seed_users
	User.create(
		name: "Sample User 1",
		email: "sample1@test.com",
		password: "cmpt276",
		activated: 1,
		activated_at: Time.zone.now)

	User.create(
		name: "Sample User 2",
		email: "sample2@test.com",
		password: "cmpt276",
		activated: 1,
		activated_at: Time.zone.now)

	User.create(
		name: "Admin User",
		email: "admin@test.com",
		password: "cmpt276",
		activated: 1,
		activated_at: Time.zone.now)
end

def read_csv
	csv_text = File.read(Rails.root.join('lib', 'seeds', 'player_data.csv'))
	return CSV.parse(csv_text, :headers => true, :encoding => 'utf-8')
end

def read_json(fname)
	file = File.read(Rails.root.join('lib', 'seeds', fname))
	return data = JSON.parse(file)
end

def seed_teams

	def seed_team(data)
		t_id = data['teamID']
		t = Team.find_by("teamID" => data[t_id])
		if !t
			puts "TEAM DOES NOT EXIST. CREATING Team #{t_id}"
			t = Team.new
		else
			puts "UPDATING TEAM #{t_id}"
		end
		# update attributes
		data.each do |key, value|
			if Team.column_names.include? key
				t[key] = value
			end
		end
		nba = League.find_by(name: "NBA")
		t.league_id = nba.id
		t.save!
	end

	fname = 'teams.json'
	data = read_json(fname)
	data.each do |team|
		seed_team(team)
	end
end

def seed_players

	def seed_player(data)
		'''
		Source: http://stats.nba.com/stats/commonallplayers?LeagueID=00&Season=2017-18&IsOnlyCurrentSeason=1
		headers:["PERSON_ID","DISPLAY_LAST_COMMA_FIRST","DISPLAY_FIRST_LAST","ROSTERSTATUS","FROM_YEAR","TO_YEAR","PLAYERCODE","TEAM_ID","TEAM_CITY","TEAM_NAME","TEAM_ABBREVIATION","TEAM_CODE","GAMES_PLAYED_FLAG"]

		Source: http://stats.nba.com/stats/leaguedashplayerbiostats?LeagueID=00&PerMode=PerGame&Season=2017-18&SeasonType=Regular%20Season
		headers:["PLAYER_ID","PLAYER_NAME","TEAM_ID","TEAM_ABBREVIATION","AGE","PLAYER_HEIGHT","PLAYER_HEIGHT_INCHES","PLAYER_WEIGHT","COLLEGE","COUNTRY","DRAFT_YEAR","DRAFT_ROUND","DRAFT_NUMBER","GP","PTS","REB","AST","NET_RATING","OREB_PCT","DREB_PCT","USG_PCT","TS_PCT","AST_PCT"]
		'''
		# get the identifier for each player
		if data.key?("PERSON_ID")
			p_id = data["PERSON_ID"]
		else
			p_id = data["PLAYER_ID"]
		end

		# returns player if exists, otherwise nil
		p = Player.find_by("PERSON_ID" => p_id)
		if !p
			puts "PLAYER DOES NOT EXIST. CREATING PLAYER #{p_id}"
			p = Player.new
		else
			puts "UPDATING PLAYER #{p_id}"
		end

		team = Team.find_by(teamID: data["TEAM_ID"])
		p.team = team
		# update attributes
		data.each do |key, value|
			if Player.column_names.include? key
				if key != "TEAM_ID"
					p[key] = value
				end
			end
		p.save!
		end
	end

	def parse_stats(url)
		headers = {"Accept-Language": "en-us","User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38","Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 'referer': 'http://stats.nba.com/'}
		resp = RestClient.get(url, headers = headers )
		return JSON.parse(resp)
	end

	# files = ['players.json', 'playerbiodata.json']
	# # load each file
	# files.each do |fname|
	# 	puts "LOOPING THROUGH FILE: #{fname}"
	# 	data = read_json(fname)
	urls = ['http://stats.nba.com/stats/commonallplayers?LeagueID=00&Season=2017-18&IsOnlyCurrentSeason=1', 'http://stats.nba.com/stats/leaguedashplayerbiostats?LeagueID=00&PerMode=PerGame&Season=2017-18&SeasonType=Regular%20Season']

	urls.each do |url|
		data = parse_stats(url)
		resultSet = data['resultSets'][0]
		rowSet = resultSet['rowSet']
		headers = resultSet['headers']

		# loop through every player and create/update
		rowSet.each do |row|
			data = Hash[headers.zip(row)]
			seed_player(data)
		end
	end
end

def seed_player_stats
	csv = read_csv
	csv.each do |row|
		identifier = row['Identifier']
		player = Player.find_by(identifier: identifier)

		p = PlayerStat.new
		p.player_id = player.id
		p.season = row["Season"]
		p.age = row["Age"]
		p.team = row["Tm"]
		p.games = row['G']
		p.games_started = row['GS']
		p.minutes = row['MP']
		p.fg = row['FG']
		p.fga = row['FGA']
		p.fgpct = row['FG_pct']
		p.fg3 = row['3P']
		p.fg3a = row['3PA']
		p.fg3pct = row['3P_pct']
		p.efgpct = row['eFG_pct']
		p.ft = row['FT']
		p.fta = row['FTA']
		p.ftpct = row['FT_pct']
		p.reboff = row['ORB']
		p.rebdef = row['DRB']
		p.rebtot = row['TRB']
		p.assists = row['AST']
		p.steals = row['STL']
		p.blocks = row['BLK']
		p.tovs = row['TOV']
		p.points = row['Pts']
		p.per = row['PER']
		p.tspct = row['TS_pct']
		p.usage = row['USG_pct']
		p.obpm = row['OBPM']
		p.dbpm = row['DBPM']
		p.bpm = row['BPM']
		p.vorp = row['VORP']
		p.save
	end
end

def seed_leagues
	l = League.create(name: 'NBA', description: "National Basketball Association")
	l.save
end

def seed_awards
	nba = League.find_by(name: "NBA")
	awards = [
		{:name => "MVP", :description => "Most Valuable Player"},
		{:name => "MIP", :description => "Most Improved Player"},
		{:name => "DPOY", :description => "Defensive Player of the Year"},
		{:name => "6MOY", :description => "Sixth Man of the Year"},
		{:name => "ROY", :description => "Rookie of the Year"}
	]

	awards.each do |award|
		a = Award.create(name: award[:name], description: award[:description], league_id: nba.id)
		a.save
	end
end


def seed_picks
	users = User.all
	nba = League.find_by(name: "NBA")
	awards = Award.all
	player_id = 30
	privacy = true

	users.each do |user|
		puts user.to_json
		if !user.admin
			awards.each do |award|
				p = Pick.create(
					user_id: user.id,
					award_id: award.id,
					player_id: player_id,
					season: 2018,
					league_id: nba.id,
					is_private: privacy
				)
				puts p.to_json
				p.save
				# alternate the privacy setting of each pick
				privacy = if privacy then false else true end
				# increment the player id
				player_id += 1
			end
		end
	end
end

# Users
def seed_fake_users
10.times do |n|
  name  = SecureRandom.hex(10)
  email = name.concat("@email.com")
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)

end

end

def seed_fake_posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
	end
end

# seed_leagues
# seed_teams
seed_players
#seed_player_stats
# seed_awards
# seed_users
# seed_picks
# seed_fake_posts
# seed_fake_users
#seed_fake_relationships
