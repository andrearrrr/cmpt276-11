class League < ApplicationRecord
	has_many :awards
	has_many :picks
	validates :name, uniqueness: { case_sensitive: false }, presence: true


	def league_name
			"#{name}"
	end
end
