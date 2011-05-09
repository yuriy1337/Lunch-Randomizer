require 'test_helper'

class GroupsPlacesControllerTest < ActionController::TestCase
  setup do
    @groups_place = groups_places(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create groups_place" do
    assert_difference('GroupsPlace.count') do
      post :create, :groups_place => @groups_place.attributes
    end

    assert_redirected_to groups_place_path(assigns(:groups_place))
  end

  test "should show groups_place" do
    get :show, :id => @groups_place.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @groups_place.to_param
    assert_response :success
  end

  test "should update groups_place" do
    put :update, :id => @groups_place.to_param, :groups_place => @groups_place.attributes
    assert_redirected_to groups_place_path(assigns(:groups_place))
  end

  test "should destroy groups_place" do
    assert_difference('GroupsPlace.count', -1) do
      delete :destroy, :id => @groups_place.to_param
    end

    assert_redirected_to groups_places_path
  end
end
