require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
	def setup
		@league = leagues(:one)
	end

	test "should be valid" do
		assert @league.valid?
	end

	test "name should be present" do
		@league.name = "     "
		assert_not @league.valid?
	end

	test "name should be unique" do
		duplicate = @league.dup
		duplicate.name = @league.name.upcase
		assert_not duplicate.valid?
	end

end
#rails test test/models/league_test.rb
