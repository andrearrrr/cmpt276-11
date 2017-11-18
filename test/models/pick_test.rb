require 'test_helper'

class PickTest < ActiveSupport::TestCase
	def setup
		@pick1 = picks(:one)
	 	@pick2 = picks(:two)

	end

	test "should be valid" do
		assert @pick1.valid?
		assert @pick2.valid?


	end

	#test for blank name
	test "season should be present and greater than 2017" do
		@pick1.season = nil
		assert_not @pick1.valid?
		@pick1.season = 2017
		assert_not @pick1.valid?
		@pick1.season = 2018
		assert @pick1.valid?
	end

	#test for blank id
	test "pick needs user" do
		@pick1.user_id = nil
		assert_not @pick1.valid?
	end

	#test for blank award
	test "pick needs award" do
		@pick1.award_id = nil
		assert_not @pick1.valid?
	end

	#test for blank league
	test "pick needs league" do
		@pick1.league_id = nil
		assert_not @pick1.valid?
	end

	#test for blank player
	test "pick needs player" do
		@pick1.player_id = nil
		assert_not @pick1.valid?
	end

	test "user can only pick award once" do
		@pick2.award_id = @pick1.award_id
		assert_not @pick2.valid?
	end

end
