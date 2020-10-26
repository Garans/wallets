# frozen_string_literal: true

module TransferStates
  module States
    class ValidatePinCode < TransferStates::StateManager
      protected

      def valid?
        @validator = PinValidator.new
        @validator.record = from_score
        @validator.pin = params[:pin_code]
        @validator.valid?
      end

      def error_message
        @validator.errors.full_messages
      end

      def next_state
        TransferStates::States::CheckEnoughMoney
      end
    end
  end
end
