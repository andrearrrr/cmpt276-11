User.create(name: "Sample User 1", email: "sample1@test.com", password: "cmpt276")
User.create(name: "Sample User 2", email: "sample2@test.com", password: "cmpt276")
User.create(name: "Admin User", email: "admin@test.com", password: "cmpt276", admin: true)


require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'player_data.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'utf-8')

csv.take(2).each do |row|
  puts row.to_hash
  puts row["Player"]
  puts row['Season']
	puts row['Identifier']
	puts row['Pos']
end
