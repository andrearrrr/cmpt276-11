class Player < ApplicationRecord
	has_many :player_stats
	has_many :picks
	validates :identifier, uniqueness: { case_sensitive: false }, presence: true
	validates :name,  presence: true

	def name_decorated
		"#{name}, #{position} - #{latest_team}"
	end

	def team_name
		"#{latest_team}"
	end

	def latest_team
		latest_season = 0
		team = ""
		self.player_stats.each do |stat|
			season = stat[:season]
			if season >= latest_season
				latest_season = season
				if stat[:team] != "TOT"
					team = stat[:team]
				end
			end
		end
		return team
	end

end
