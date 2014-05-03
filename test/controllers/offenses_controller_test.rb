require 'test_helper'

class OffensesControllerTest < ActionController::TestCase
  setup do
    @offense = offenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offense" do
    assert_difference('Offense.count') do
      post :create, offense: { c_ball: @offense.c_ball, c_x: @offense.c_x, c_y: @offense.c_y, name: @offense.name, pf_ball: @offense.pf_ball, pf_x: @offense.pf_x, pf_y: @offense.pf_y, pg_ball: @offense.pg_ball, pg_x: @offense.pg_x, pg_y: @offense.pg_y, sf_ball: @offense.sf_ball, sf_x: @offense.sf_x, sf_y: @offense.sf_y, sg_ball: @offense.sg_ball, sg_x: @offense.sg_x, sg_y: @offense.sg_y }
    end

    assert_redirected_to offense_path(assigns(:offense))
  end

  test "should show offense" do
    get :show, id: @offense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offense
    assert_response :success
  end

  test "should update offense" do
    patch :update, id: @offense, offense: { c_ball: @offense.c_ball, c_x: @offense.c_x, c_y: @offense.c_y, name: @offense.name, pf_ball: @offense.pf_ball, pf_x: @offense.pf_x, pf_y: @offense.pf_y, pg_ball: @offense.pg_ball, pg_x: @offense.pg_x, pg_y: @offense.pg_y, sf_ball: @offense.sf_ball, sf_x: @offense.sf_x, sf_y: @offense.sf_y, sg_ball: @offense.sg_ball, sg_x: @offense.sg_x, sg_y: @offense.sg_y }
    assert_redirected_to offense_path(assigns(:offense))
  end

  test "should destroy offense" do
    assert_difference('Offense.count', -1) do
      delete :destroy, id: @offense
    end

    assert_redirected_to offenses_path
  end
end
