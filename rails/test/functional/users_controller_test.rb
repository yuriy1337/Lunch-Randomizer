require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @update = { :username => "new_user", :hashed_password => "adksfjladsfjkladsfjk", :email => "myemail@myprovider.net", :language => "en"}
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => @update
    end

    assert_redirected_to login_path
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end
end
