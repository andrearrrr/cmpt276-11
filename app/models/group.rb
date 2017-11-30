class Group < ApplicationRecord
  has_many :users
  validates :name, uniqueness: { case_sensitive: false }, presence: true

  attr_accessor :name
end
