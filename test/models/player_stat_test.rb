require 'test_helper'

class PlayerStatTest < ActiveSupport::TestCase
	def setup
		@player1 = Player.new(name: "My Player", identifier: "myplayer123",
										 position: "PG")
		@player1.save
		@playerstat1 = PlayerStat.new(player_id: @player1.id, season: 2016, team: "BOS")

	end

	#test that creating a new user is working
	test "should be valid" do
		assert @playerstat1.valid?
	end

	#test for blank name
	test "seasons should be present" do
	@playerstat1.season = nil
	assert_not @playerstat1.valid?
	end

	#test for blank id
	test "season should be >= 2015" do
	@playerstat1.season = 2014
	assert_not @playerstat1.valid?
	@playerstat1.season = 2016
	assert @playerstat1.valid?
	end

	test "identifer should be unique" do
		#creates a duplicate user as the example user
		duplicate_player = @player1.dup
		#emails are not case sensitive, so change to all uppercase
		duplicate_player.identifier = @player1.identifier.upcase
		@player1.save
		assert_not duplicate_player.valid?
	end

end
