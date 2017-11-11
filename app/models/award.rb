class Award < ApplicationRecord
	belongs_to :league
	validates :name, uniqueness: { scope: [:league_id], case_sensitive: false }, presence: true
end
