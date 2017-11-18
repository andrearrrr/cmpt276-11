require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

	def setup
		@player1 = players(:one)
	end

	#test that creating a new user is working
	test "should be valid" do
		assert @player1.valid?
	end

	#test for blank name
	test "name should be present" do
	@player1.name = "     "
	assert_not @player1.valid?
	end

	#test for blank id
	test "identifier should be present" do
	@player1.identifier = "     "
	assert_not @player1.valid?
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
