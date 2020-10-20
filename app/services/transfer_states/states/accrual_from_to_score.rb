# frozen_string_literal: true

module TransferStates
  module States
    class AccrualFromToScore < TransferStates::States::CreateChargeTransaction
      def next
        return execute if valid?

        raise StandardError, error_message
      end

      protected

      def execute
        super
        Transaction.transaction do
          @transaction.update(status: Transaction.transaction_statuses[:success])
          params[:parent].update(status: Transaction.transaction_statuses[:success]) if params[:parent].present?
        end
      end

      def builder
        Builders::TransactionBuilder.build(params[:parent]) do |t|
          yield t
        end
      end

      def operation_type
        Transaction.operation_types[:accrual]
      end

      def valid?
        params[:parent].status == Transaction.transaction_statuses[:in_progress]
      end

      def error_message
        'Incorrect parent transaction'
      end
    end
  end
end
