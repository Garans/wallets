require 'test_helper'

class CreateTransactionTest < ActiveSupport::TestCase
  fixtures :all   # include all fixtures

  def test_create_transaction
    params = { operation_type: Transaction.operation_types[:charge],
               from_score: Wallet.first.number,
               to_score: Wallet.last.number, recipient_type: :wallet, amount: 100 }

    transaction_count_before = Transaction.count
    transaction = CreateTransaction.perform(params)
    assert_not_equal transaction_count_before, Transaction.count
    assert_equal transaction.transaction_send_info.last.sender.number, Wallet.first.number
    assert_equal transaction.transaction_send_info.last.recipient.number, Wallet.last.number
  end
end
