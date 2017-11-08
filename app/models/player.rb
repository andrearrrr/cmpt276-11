class Player < ApplicationRecord
	has_many :playerstats
	validates :identifier, uniqueness: true
end
