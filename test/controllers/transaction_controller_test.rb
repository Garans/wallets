require 'test_helper'
require 'rake'

class TransactionControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.load_seed
    InterviewProject::Application.load_tasks if Rake::Task.tasks.empty?
    Rake::Task['population:generate_wallet_list'].invoke
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
  end

  test "should get create" do
    params = {
      recipient_type: :wallet,
      from_score: Wallet.first.number,
      to_score: Wallet.last.number,
      amount: 100,
      pin_code: '1234'
    }

    post transaction_index_url, params: params, headers: { 'content-type': 'multipart/form-data' }
    assert_equal Wallet.last.balance, 2844.48
  end

  test "Not enough money" do
    params = {
      recipient_type: :wallet,
      from_score: Wallet.first.number,
      to_score: Wallet.last.number,
      amount: 100000,
      pin_code: '1234'
    }

    post transaction_index_url, params: params, headers: { 'content-type': 'multipart/form-data' }
    assert_equal 'Not enough money on USD12308585004698286451601579 funds must be more 101000.0', flash[:error]
    assert_equal 10000.0, Wallet.first.balance
    assert_equal 0.0, Wallet.last.balance
  end
end
