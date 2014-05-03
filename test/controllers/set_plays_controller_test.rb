require 'test_helper'

class SetPlaysControllerTest < ActionController::TestCase
  setup do
    @set_play = set_plays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:set_plays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create set_play" do
    assert_difference('SetPlay.count') do
      post :create, set_play: { name: @set_play.name, type: @set_play.type }
    end

    assert_redirected_to set_play_path(assigns(:set_play))
  end

  test "should show set_play" do
    get :show, id: @set_play
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @set_play
    assert_response :success
  end

  test "should update set_play" do
    patch :update, id: @set_play, set_play: { name: @set_play.name, type: @set_play.type }
    assert_redirected_to set_play_path(assigns(:set_play))
  end

  test "should destroy set_play" do
    assert_difference('SetPlay.count', -1) do
      delete :destroy, id: @set_play
    end

    assert_redirected_to set_plays_path
  end
end
