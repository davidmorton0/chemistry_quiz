require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:new_user)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = nil
    assert_not @user.valid?
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "should return a hash digest" do
    digest = User.digest("string")
    assert_equal digest.length, 60
  end
  
  test "should return a token" do
    token = User.new_token
    assert_equal token.length, 22
  end
  
  test "should remember a token" do
    assert_nil @user.remember_digest
    @user.remember
    assert_equal @user.remember_digest.length, 60
  end
  
  test "authenticated? should return true when a token matches a digest" do
    @user.remember
    assert @user.authenticated?(:remember, @user.remember_token)
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,'')
  end
  
  test "should forget a remember digest" do
    @user.remember
    @user.forget
    assert_nil @user.remember_digest
  end
  
  test "should create activation digest before user create" do
    @user = build(:new_user)
    assert_nil @user.activation_digest
    @user.save
    assert_not_nil @user.activation_digest
  end
  
  test "should activate a user" do
    @user = create(:new_user, :not_activated)
    assert_not @user.reload.activated
    @user.activate
    assert @user.reload.activated
  end
  
  test "should send activation email" do
    ActionMailer::Base.deliveries.clear
    @user.send_activation_email
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
  
  test "should create a reset digest" do
    assert_nil @user.reload.reset_digest
    assert_nil @user.reload.reset_sent_at
    @user.create_reset_digest
    assert_equal @user.reload.reset_digest.length, 60
    assert_not_nil @user.reset_sent_at
  end
  
  test "should send password reset email" do
    ActionMailer::Base.deliveries.clear
    @user.create_reset_digest
    @user.send_password_reset_email
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
  
  test "should return true if password reset has expired" do
    @user.create_reset_digest
    @user.reset_sent_at = 3.hours.ago
    assert @user.password_reset_expired?
  end
  
  test "should return false if password reset has not expired" do
    @user.create_reset_digest
    @user.reset_sent_at = 1.hour.ago
    assert_not @user.password_reset_expired?
  end

end
