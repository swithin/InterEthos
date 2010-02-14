require 'test_helper'

class UsersTeamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_team" do
    assert_difference('UsersTeam.count') do
      post :create, :users_team => { }
    end

    assert_redirected_to users_team_path(assigns(:users_team))
  end

  test "should show users_team" do
    get :show, :id => users_teams(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users_teams(:one).to_param
    assert_response :success
  end

  test "should update users_team" do
    put :update, :id => users_teams(:one).to_param, :users_team => { }
    assert_redirected_to users_team_path(assigns(:users_team))
  end

  test "should destroy users_team" do
    assert_difference('UsersTeam.count', -1) do
      delete :destroy, :id => users_teams(:one).to_param
    end

    assert_redirected_to users_teams_path
  end
end
