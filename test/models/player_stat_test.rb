require 'test_helper'

class PlayerStatTest < ActiveSupport::TestCase
	def setup
		@playerstat1 = player_stats(:one)

	end

	test "should be valid" do
		assert @playerstat1.valid?
	end

	test "seasons should be present" do
		@playerstat1.season = nil
		assert_not @playerstat1.valid?
	end

	test "season should be >= 2015" do
		@playerstat1.season = 2014
		assert_not @playerstat1.valid?
		@playerstat1.season = 2016
		assert @playerstat1.valid?
	end

	test "identifer should be unique" do
		duplicate_player_stat = @playerstat1.dup
		# duplicate_player.identifier = @player1.identifier.upcase
		# @player1.save
		assert_not duplicate_player_stat.valid?
	end

end
