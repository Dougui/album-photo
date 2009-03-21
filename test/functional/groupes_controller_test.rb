require 'test_helper'

class GroupesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groupes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create groupe" do
    assert_difference('Groupe.count') do
      post :create, :groupe => { }
    end

    assert_redirected_to groupe_path(assigns(:groupe))
  end

  test "should show groupe" do
    get :show, :id => groupes(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => groupes(:one).id
    assert_response :success
  end

  test "should update groupe" do
    put :update, :id => groupes(:one).id, :groupe => { }
    assert_redirected_to groupe_path(assigns(:groupe))
  end

  test "should destroy groupe" do
    assert_difference('Groupe.count', -1) do
      delete :destroy, :id => groupes(:one).id
    end

    assert_redirected_to groupes_path
  end
end
