class Player < ApplicationRecord
	has_many :player_stats
	has_many :picks
	belongs_to :team, :foreign_key => :TEAM_ID, :primary_key => :teamID, optional: true
	after_initialize :init

	def init
		stat_cols = ["GP","PTS","REB","AST","NET_RATING","USG_PCT","TS_PCT"]
		stat_cols.each do |stat|
			self[stat] ||= 0
		end
	end
	# validates :identifier, uniqueness: { case_sensitive: false }, presence: true
	# validates :name,  presence: true

	def player_rating
		return self["PTS"] + self["REB"] + self["AST"]
	end

	# def name_decorated
	# 	"#{name}, #{position} - #{latest_team}"
	# end
	#
	# def latest_team
	# 	latest_season = 0
	# 	team = ""
	# 	self.player_stats.each do |stat|
	# 		season = stat[:season]
	# 		if season >= latest_season
	# 			latest_season = season
	# 			if stat[:team] != "TOT"
	# 				team = stat[:team]
	# 			end
	# 		end
	# 	end
	# 	return team
	# end

end
