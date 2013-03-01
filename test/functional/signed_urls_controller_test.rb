require 'test_helper'

class SignedUrlsControllerTest < ActionController::TestCase
  setup do
    @signed_url = signed_urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:signed_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create signed_url" do
    assert_difference('SignedUrl.count') do
      post :create, signed_url: {  }
    end

    assert_redirected_to signed_url_path(assigns(:signed_url))
  end

  test "should show signed_url" do
    get :show, id: @signed_url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @signed_url
    assert_response :success
  end

  test "should update signed_url" do
    put :update, id: @signed_url, signed_url: {  }
    assert_redirected_to signed_url_path(assigns(:signed_url))
  end

  test "should destroy signed_url" do
    assert_difference('SignedUrl.count', -1) do
      delete :destroy, id: @signed_url
    end

    assert_redirected_to signed_urls_path
  end
end
