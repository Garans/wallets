# frozen_string_literal: true

require 'test_helper'
require 'rake'

class CreateScoreTest < ActiveSupport::TestCase
  fixtures :all   # include all fixtures

  def test_call
    build = CreateScore.new(
      UserWallet.new,
      User.first,
      { currency_id: 'USD', description: 'test', pin: '1234' }
    )
    wallet = build.call
    assert_equal 10000.0, wallet.balance
    assert_equal false, WalletAvailable.first.status
  end
end
