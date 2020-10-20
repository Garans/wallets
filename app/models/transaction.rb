# frozen_string_literal: true

class Transaction < ApplicationRecord
  # has_and_belongs_to_many :charge_transactions, join_table: :transactions_wallets
  # belongs_to :sender_wallet, class_name: 'Wallet', foreign_key: 'sender_wallet_id', optional: true
  # belongs_to :recipient_wallet, class_name: 'Wallet', foreign_key: 'recipient_wallet_id'
  has_one :children, class_name: 'Transaction', foreign_key: :parent_id
  has_many :transaction_send_info

  belongs_to :currency
  belongs_to :commission_rule, optional: true
  belongs_to :parent, class_name: 'Transaction', optional: true

  enum operation_type: { charge: 0, accrual: 1, refund: 2, decline: 3, incorrect_operation: 4 }
  enum transaction_status: { new: 0, in_progress: 1, success: 2, failed: 3 }, _prefix: :transaction

  def self.active_sender_operation
    [operation_types[:charge], operation_types[:refund]]
  end

  def self.active_recipient_operation
    [operation_types[:accrual]]
  end
end
