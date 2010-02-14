require 'test_helper'

class CategoriesCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories_category" do
    assert_difference('CategoriesCategory.count') do
      post :create, :categories_category => { }
    end

    assert_redirected_to categories_category_path(assigns(:categories_category))
  end

  test "should show categories_category" do
    get :show, :id => categories_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories_categories(:one).to_param
    assert_response :success
  end

  test "should update categories_category" do
    put :update, :id => categories_categories(:one).to_param, :categories_category => { }
    assert_redirected_to categories_category_path(assigns(:categories_category))
  end

  test "should destroy categories_category" do
    assert_difference('CategoriesCategory.count', -1) do
      delete :destroy, :id => categories_categories(:one).to_param
    end

    assert_redirected_to categories_categories_path
  end
end
