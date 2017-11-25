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

def read_json
	fname = 'players.json'
	file = File.read(Rails.root.join('lib', 'seeds', fname))
	return data = JSON.parse(file)
end

'''
create_table "players", force: :cascade do |t|
	t.string "name"
	t.string "identifier"
	t.string "position"
	t.datetime "created_at", null: false
	t.datetime "updated_at", null: false
	t.integer "PERSON_ID"
	t.string "DISPLAY_LAST_COMMA_FIRST"
	t.string "DISPLAY_FIRST_LAST"
	t.string "FROM_YEAR"
	t.string "TO_YEAR"
	t.string "PLAYERCODE"
	t.integer "TEAM_ID"
	t.string "TEAM_CITY"
	t.string "TEAM_NAME"
	t.string "TEAM_ABBREVIATION"
	t.string "TEAM_CODE"
end
'''
#[203518,"Abrines, Alex","Alex Abrines",1,"2016","2017","alex_abrines",1610612760,"Oklahoma City","Thunder","OKC","thunder","Y"]

def seed_players
	data = read_json
	resultSet = data['resultSets'][0]
	rowSet = resultSet['rowSet']

	rowSet.take(10).each do |row|
		person_id = row[0]
		if !Player.where(:PERSON_ID => person_id).exists?
			p = Player.new
			p.PERSON_ID = person_id
			p.DISPLAY_LAST_COMMA_FIRST = row[1]
			p.DISPLAY_FIRST_LAST = row[2]
			p.FROM_YEAR = row[4]
			p.TO_YEAR = row[5]
			p.PLAYERCODE = row[6]
			p.TEAM_ID = row[7]
			p.TEAM_CITY = row[8]
			p.TEAM_NAME = row[9]
			p.TEAM_ABBREVIATION = row[10]
			p.TEAM_CODE = row[11]
			puts p.to_json
			print p.save!

		end
	end
end

# def seed_players
# 	csv = read_csv
# 	csv.each do |row|
# 		identifier = row['Identifier']
# 		name = row['Player']
# 		position = row['Pos']
# 		puts identifier
# 		if !Player.where(:identifier => identifier).exists?
# 			puts name, identifier
# 			p = Player.new
# 			p.name = name
# 			p.identifier = identifier
# 			p.position = position
# 			puts p.to_json
# 			p.save
# 			print p.save
# 		end
# 	end
# end


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




seed_players
# seed_player_stats
# seed_leagues
# seed_awards
# seed_users
# seed_picks
# seed_fake_posts
#seed_fake_users
#seed_fake_relationships
