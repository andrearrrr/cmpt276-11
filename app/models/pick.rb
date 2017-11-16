class Pick < ApplicationRecord
	belongs_to :user
	belongs_to :league
	belongs_to :player
	belongs_to :award

	validates :award_id, presence: true,  uniqueness: { scope: [:user_id, :league_id] }
	validates :season,  presence: true, :numericality => {:greater_than => 2017}
	validates :player_id,  presence: true
	validates :league_id,  presence: true
	validates :user_id,  presence: true
end
