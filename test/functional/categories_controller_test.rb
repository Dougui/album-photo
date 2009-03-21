require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorie" do
    assert_difference('Categorie.count') do
      post :create, :categorie => { }
    end

    assert_redirected_to categorie_path(assigns(:categorie))
  end

  test "should show categorie" do
    get :show, :id => categories(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:one).id
    assert_response :success
  end

  test "should update categorie" do
    put :update, :id => categories(:one).id, :categorie => { }
    assert_redirected_to categorie_path(assigns(:categorie))
  end

  test "should destroy categorie" do
    assert_difference('Categorie.count', -1) do
      delete :destroy, :id => categories(:one).id
    end

    assert_redirected_to categories_path
  end
end
