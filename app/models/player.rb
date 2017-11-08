class Player < ApplicationRecord
	has_many :player_stats
	validates :identifier, uniqueness: true
end
