User.create(name: "Sample User 1", email: "sample1@test.com", password: "cmpt276")
User.create(name: "Sample User 2", email: "sample2@test.com", password: "cmpt276")
User.create(name: "Admin User", email: "admin@test.com", password: "cmpt276", admin: true)


require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'player_data.csv'))
$csv = CSV.parse(csv_text, :headers => true, :encoding => 'utf-8')

def seed_players
	$csv.each do |row|
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
