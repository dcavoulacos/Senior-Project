require 'test_helper'

class ActionFramesControllerTest < ActionController::TestCase
  setup do
    @action_frame = action_frames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:action_frames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create action_frame" do
    assert_difference('ActionFrame.count') do
      post :create, action_frame: {  }
    end

    assert_redirected_to action_frame_path(assigns(:action_frame))
  end

  test "should show action_frame" do
    get :show, id: @action_frame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @action_frame
    assert_response :success
  end

  test "should update action_frame" do
    patch :update, id: @action_frame, action_frame: {  }
    assert_redirected_to action_frame_path(assigns(:action_frame))
  end

  test "should destroy action_frame" do
    assert_difference('ActionFrame.count', -1) do
      delete :destroy, id: @action_frame
    end

    assert_redirected_to action_frames_path
  end
end
