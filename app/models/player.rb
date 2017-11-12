class Player < ApplicationRecord
	has_many :player_stats
	validates :identifier, uniqueness: { case_sensitive: false }, presence: true
	validates :name,  presence: true
end
