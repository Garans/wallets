require 'test_helper'

class WalletControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wallet_index_url
    assert_response :success
  end

  test "should get show" do
    get wallet_show_url
    assert_response :success
  end

  test "should get create" do
    get wallet_create_url
    assert_response :success
  end

  test "should get update" do
    get wallet_update_url
    assert_response :success
  end

  test "should get destroy" do
    get wallet_destroy_url
    assert_response :success
  end

  test "should get new" do
    get wallet_new_url
    assert_response :success
  end

end
