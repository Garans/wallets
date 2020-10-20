# frozen_string_literal: true

class Wallet < ApplicationRecord
  include Vault::EncryptedModel
  vault_attribute :number

  has_and_belongs_to_many :users
  belongs_to :currency
  has_and_belongs_to_many :charge_transactions, join_table: :transactions_wallets, class_name: 'Transaction'

  has_many :out_come_transactions, class_name: 'Transaction', foreign_key: 'sender_wallet_id'
  has_many :in_come_transactions, class_name: 'Transaction', foreign_key: 'recipient_wallet_id'

  has_one :crypted_datum, as: :owner

  has_many :out_come_send_info, class_name: 'TransactionSendInfo', foreign_key: 'sender_id', as: :sender
  has_many :in_come_send_info, class_name: 'TransactionSendInfo', foreign_key: 'recipient_id', as: :recipient

  def balance
    out_come = load_transactions('sender', 'full_amount')
    in_come = load_transactions('recipient', 'amount')

    out_come + in_come
  end

  def load_transactions(directly, sum_field)
    Transaction.joins(:transaction_send_info).where(
      TransactionSendInfo.table_name => { "#{directly}_id" => id, "#{directly}_type" => self.class.name }
    ).sum("#{Transaction.table_name}.#{sum_field}")
  end

  def wallet_type_present
    (type.remove('Wallet')).humanize
  end

  class << self
    def exists_identity?(score)
      status = false
      find_each.each do |record|
        next if record.number != score

        status = true
      end
      status
    end

    def find_wallet_by_in_crypt(number)
      wallet = nil
      find_each.each do |record|
        next if record.number != number

        wallet = record
        break
      end
      wallet
    end
  end
end
