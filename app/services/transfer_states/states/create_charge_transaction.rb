# frozen_string_literal: true

module TransferStates
  module States
    class CreateChargeTransaction < ::TransferStates::StateManager
      attr_reader :transaction

      def next
        raise StandardError, error_message unless valid?

        execute
        next_state.perform(params.merge(parent: @transaction))
      end

      protected

      def execute
        @transaction = CreateTransaction.perform(params.merge(operation_type: operation_type))
      end

      def operation_type
        Transaction.operation_types[:charge]
      end

      def next_state
        TransferStates::States::AccrualFromToScore
      end
    end
  end
end
