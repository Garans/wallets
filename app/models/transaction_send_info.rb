# frozen_string_literal: true

class TransactionSendInfo < ApplicationRecord
  belongs_to :sender, polymorphic: true, optional: true
  belongs_to :recipient, polymorphic: true
  belongs_to :charge_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
end
