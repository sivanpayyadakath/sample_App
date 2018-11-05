require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password:"foobar", password_confirmation:"foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should  not be too long" do
    @user.email = "a" * 250 + "@example.com"
    assert_not @user.valid?
  end

  test "email validations should accept valid addresses" do
    valid_add = %w[user@example.com USER@foo.com a_US-er@foo.bar.org first.last@foo.jp alice+bob@ccc.k]
    valid_add.each do |v|
      @user.email=v
      assert @user.valid?, "#{valid_add.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_add= %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_add.each do |inv|
      @user.email = inv
      assert_not @user.valid?, "#{invalid_add.inspect} should be valid"
    end
  end

  test "email addresses should  be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixcase_email = "foo@Example.coM"
    @user.email = mixcase_email
    @user.save
    assert_equal mixcase_email.downcase,@user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password=@user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

