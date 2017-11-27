class Team < ApplicationRecord
	self.primary_key = 'teamID'
	has_many :players
	belongs_to :league
end
