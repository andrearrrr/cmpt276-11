class League < ApplicationRecord
	validates :name, uniqueness: { case_sensitive: false }, presence: true
end
