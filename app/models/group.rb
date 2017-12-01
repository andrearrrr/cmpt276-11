class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100}, uniqueness: true
  has_many :users
end
