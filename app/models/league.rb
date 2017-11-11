class League < ApplicationRecord
	has_many :awards
	validates :name, uniqueness: { case_sensitive: false }, presence: true
end
