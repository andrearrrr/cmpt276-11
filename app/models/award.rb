class Award < ApplicationRecord
	has_many :picks
	belongs_to :league
	validates :name, uniqueness: { scope: [:league_id], case_sensitive: false }, presence: true


	def full_name
			"#{name} - #{description}"
	end
end
