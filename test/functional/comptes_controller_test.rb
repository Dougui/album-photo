require 'test_helper'

class ComptesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comptes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comptes" do
    assert_difference('Comptes.count') do
      post :create, :comptes => { }
    end

    assert_redirected_to comptes_path(assigns(:comptes))
  end

  test "should show comptes" do
    get :show, :id => comptes(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => comptes(:one).id
    assert_response :success
  end

  test "should update comptes" do
    put :update, :id => comptes(:one).id, :comptes => { }
    assert_redirected_to comptes_path(assigns(:comptes))
  end

  test "should destroy comptes" do
    assert_difference('Comptes.count', -1) do
      delete :destroy, :id => comptes(:one).id
    end

    assert_redirected_to comptes_path
  end
end
