require 'test_helper'
require 'rake'

class WalletControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.load_seed
    InterviewProject::Application.load_tasks if Rake::Task.tasks.empty?
    Rake::Task['population:generate_wallet_list'].invoke
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
  end

  test "should get index" do
    get wallet_index_url
    assert_response :success
  end

  test "should get show" do
    get wallet_url(id: 1)
    assert_response :success
  end

  test "should get create" do
    get new_wallet_url(wallet_type: :team)
    assert_response :success
  end

  test 'Check update wallet without pin code' do
    wallet = Wallet.first
    patch wallet_url(wallet_type: :user, id: wallet.id), params: { user_wallet: { wallet_type: :user, description: 'test' } }, headers: { 'content-type': 'multipart/form-data' }
    assert_equal 'Pin code must be from 4 number elements, Pin code incorrect', flash[:error]
    assert_response :bad_request
  end

  test 'Update wallet with incorrect pin code' do
    wallet = Wallet.first
    patch wallet_url(wallet_type: :user, id: wallet.id), params: { user_wallet: { wallet_type: :user, description: 'test', pin: '1222' } }, headers: { 'content-type': 'multipart/form-data' }
    assert_equal 'Pin code incorrect', flash[:error]
    assert_response :bad_request
  end

  test 'Update description' do
    wallet = Wallet.first
    patch wallet_url(wallet_type: :user, id: wallet.id), params: { user_wallet: { wallet_type: :user, description: 'test', pin: '1234' } }, headers: { 'content-type': 'multipart/form-data' }
    assert_equal 'test', wallet.reload.description
  end

  test "should get new" do
    get new_wallet_url(wallet_type: :user)
    assert_response :success
  end

end
