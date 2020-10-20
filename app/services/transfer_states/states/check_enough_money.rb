# frozen_string_literal: true

module TransferStates
  module States
    class CheckEnoughMoney < ::TransferStates::StateManager
      protected

      def valid?
        from_score.balance >= (amount + commission)
      end

      def commission
        @commission ||= CommissionRule.select_commission(amount)&.commission_amount(amount)
      end

      def error_message
        "Not enough money on #{from_score.number} funds must be more #{amount + commission}"
      end

      def next_state
        TransferStates::States::CreateChargeTransaction
      end
    end
  end
end
