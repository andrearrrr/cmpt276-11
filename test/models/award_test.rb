require 'test_helper'

class AwardTest < ActiveSupport::TestCase
	def setup
		@award = awards(:one)
	end

	test "should be valid" do
		assert @award.valid?
	end

	test "name should be present" do
		@award.name = "     "
		assert_not @award.valid?
	end

	test "name should be unique" do
		duplicate = @award.dup
		duplicate.name = @award.name.upcase
		assert_not duplicate.valid?
	end
  # test "the truth" do
  #   assert true
  # end
end
