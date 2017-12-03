class Team < ApplicationRecord
	self.primary_key = 'teamID'
	has_many :players, :foreign_key => :TEAM_ID, :primary_key => :teamID
	belongs_to :league
end
