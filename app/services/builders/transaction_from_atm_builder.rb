# frozen_string_literal: true

module Builders
  class TransactionFromAtmBuilder < TransactionBuilder

    def currency
      transaction.currency = recipient_wallet.currency
    end

    protected

    def currency_change?
      false
    end
  end
end
