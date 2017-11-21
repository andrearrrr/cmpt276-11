require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  #test that creating a new user is working
  test "should be valid" do
    assert @user.valid?
  end

  #NAMES

  #test for blank name
  test "name should be present" do
  @user.name = "     "
  assert_not @user.valid?
  end

  #test for blank email
  test "email should be present" do
  @user.email = "     "
  assert_not @user.valid?
  end

  #tests for length of name; must be < 51 characters
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  #EMAILS

  #tests for length of email; must be < 244 characters before the domain
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  #testing for some examples of valid emails
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
  end

  #testing for some examples of invalid emails
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@foobar..com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
  end

  #testing for unique emails
  test "email addresses should be unique" do
    #creates a duplicate user as the example user
    duplicate_user = @user.dup
    #emails are not case sensitive, so change to all uppercase
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  #test that emails are saved in DB in all lowercase
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  #PASSWORDS

  #password must be present (not blank)
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  #password must be at least 6 characters
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  #used to test for having app loggin in in two or more different browsers
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
