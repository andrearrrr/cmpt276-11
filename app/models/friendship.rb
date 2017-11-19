class Friendship < ApplicationRecord
  belongs_to :send, class_name: "User"
  belongs_to :recieve, class_name: "User"
  validates :send_id, presence: true
  validates :recieve_id, presence: true
end
