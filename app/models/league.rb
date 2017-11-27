class League < ApplicationRecord
	has_many :awards
	has_many :picks
	has_many :teams
	validates :name, uniqueness: { case_sensitive: false }, presence: true
end
