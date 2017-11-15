class Pick < ApplicationRecord
	belongs_to :user
	belongs_to :league
	belongs_to :player
	belongs_to :award

	validates :award, presence: true,  uniqueness: { scope: [:user, :league] }
	validates :player_id,  presence: true
	validates :league_id,  presence: true
	validates :user_id,  presence: true
end
