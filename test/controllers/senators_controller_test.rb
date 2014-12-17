require 'test_helper'

class SenatorsControllerTest < ActionController::TestCase
  setup do
    @senator = senators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:senators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create senator" do
    assert_difference('Senator.count') do
      post :create, senator: { category: @senator.category, district: @senator.district, legislator: @senator.legislator }
    end

    assert_redirected_to senator_path(assigns(:senator))
  end

  test "should show senator" do
    get :show, id: @senator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @senator
    assert_response :success
  end

  test "should update senator" do
    patch :update, id: @senator, senator: { category: @senator.category, district: @senator.district, legislator: @senator.legislator }
    assert_redirected_to senator_path(assigns(:senator))
  end

  test "should destroy senator" do
    assert_difference('Senator.count', -1) do
      delete :destroy, id: @senator
    end

    assert_redirected_to senators_path
  end
end
