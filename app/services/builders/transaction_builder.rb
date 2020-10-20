# frozen_string_literal: true

module Builders
  class TransactionBuilder
    attr_reader :transaction, :parent

    def initialize(parent = nil)
      @parent = parent
      @transaction = Transaction.new(parent: parent)
    end

    def self.build(parent = nil)
      builder = new(parent)
      yield(builder)
      builder.transaction
    end

    def description(value)
      transaction.description = value
    end

    def recipient(wallet)
      @recipient_wallet = wallet
    end

    def sender(wallet)
      @sender_wallet = wallet
    end

    def operation_type(type)
      transaction.operation_type = type
    end

    def currency
      transaction.currency = send("#{parent.present? ? 'sender' : 'recipient'}_wallet").currency
    end

    def currency_converters_info
      return unless currency_change?

      transaction.currency_converters_info = currency_converter
    end

    def status(value)
      transaction.status = value
    end

    def build_amount(amount)
      commission = commission_build(amount)
      if from_sender?
        transaction.amount = amount * -1
        transaction.full_amount = transaction.amount + (commission * -1)
      else
        amount = CalculateCurrencyConverter.new(currency_converter).call(amount) if currency_change?

        transaction.amount = amount
        transaction.full_amount = amount
      end
    end

    def commission_build(amount)
      return 0 unless from_sender?

      commission = CommissionRule.select_commission(amount)

      return 0 if commission.blank?

      transaction.commission_rule = commission

      transaction.commission_amount = commission.commission_amount(amount)
    end

    protected

    attr_reader :sender_wallet, :recipient_wallet

    def from_sender?
      %w[charge refund].include?(transaction.operation_type)
    end

    def currency_converter
      return parent&.currency_converters_info unless from_sender?

      CurrencyConverter.find_by(
        first_currency: sender_wallet.currency, second_currency: recipient_wallet.currency
      ).as_json
    end

    def currency_change?
      sender_wallet.currency != recipient_wallet.currency
    end
  end
end
