require 'csv'

def seed_users
	User.create(name: "Sample User 1", email: "sample1@test.com", password: "cmpt276")
	User.create(name: "Sample User 2", email: "sample2@test.com", password: "cmpt276")
	User.create(name: "Admin User", email: "admin@test.com", password: "cmpt276", admin: true)
end

def read_csv
	csv_text = File.read(Rails.root.join('lib', 'seeds', 'player_data.csv'))
	return CSV.parse(csv_text, :headers => true, :encoding => 'utf-8')
end

def seed_players
	csv = read_csv
	csv.each do |row|
		identifier = row['Identifier']
		name = row['Player']
		position = row['Pos']
		puts identifier
		if !Player.where(:identifier => identifier).exists?
			puts name, identifier
			p = Player.new
			p.name = name
			p.identifier = identifier
			p.position = position
			puts p.to_json
			p.save
			print p.save
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
		p.team = row["Team"]
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
		puts p.save
	end
end

seed_player_stats
