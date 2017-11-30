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

	def mvp_rating
		numerator = self["PTS"] + self["REB"] + self["AST"]
		denominator = (1 -self["TS_PCT"]) *  (1 -self["USG_PCT"])
		return (denominator == 0) ? 0 : ((numerator / denominator) / 2).round(1)
	end

	def mvp_rank
		mvp_rating = mvp_rating()
		count = 1
		for player in Player.all
			if player.mvp_rating > mvp_rating
				count +=1
			end
		end
		return count
	end

	def rookie_rank
		mvp_rating = mvp_rating()
		count = 1
		for player in Player.all
			if player.DRAFT_YEAR == "2017" && player.mvp_rating > mvp_rating
				count +=1
			end
		end
		return count
	end

	def sixthman_rank
		mvp_rating = mvp_rating()
		count = 1
		for player in Player.all
			if player.DRAFT_YEAR == "2017" && player.mvp_rating > mvp_rating
				count +=1
			end
		end
		return count
	end

end
