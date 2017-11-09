class PlayerStat < ApplicationRecord
	belongs_to :player
	validates :season,  presence: true, :numericality => {:greater_than => 2000}
	validates :player_id, uniqueness: { scope: [:season, :team] }
end
