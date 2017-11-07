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

def seed_players
	csv = read_csv
	csv.take(5).each do |row|
		identifier = row['Identifier']
		player = Player.where(:identifier => identifier)
		puts player.to_json
		identifier = row['Identifier']
		name = row['Player']
		position = row['Pos']
		puts name, position

	end
end

seed_players
