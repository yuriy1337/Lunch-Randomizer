require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end

  test "valid user is accepted" do
    user = User.new(:username => "new_user", :email => "new@email.com", :password => "password", :language => "en")
    assert user.valid?
  end

  test "duplicate username not allowed" do
    user = User.new(:username => users(:one).username, :email => "myemail@email.com", :password => "password", :language => "en")
    assert !user.save
  end
end
