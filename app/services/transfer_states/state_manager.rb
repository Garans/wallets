# frozen_string_literal: true

module TransferStates
  class StateManager
    attr_reader :state, :params

    def self.perform(params)
      new(params).next
    end

    def initialize(params)
      @params = params
    end

    def next
      raise StandardError, error_message unless valid?

      data = execute
      return data if need_stop?

      next_state.perform(params)
    end

    protected

    def need_stop?
      false
    end

    def from_score
      @from_score ||= Wallet.find_wallet_by_in_crypt(params[:from_score])
    end

    def recipient_score
      @recipient_score ||= Wallet.find_wallet_by_in_crypt(params[:to_score])
    end

    def amount
      params[:amount].to_f
    end

    def recipient_type
      params[:recipient_type].to_sym
    end

    def valid?
      true
    end

    def execute; end

    def error_message; end

    private

    def next_state
      TransferStates::States::ValidatePinCode
    end
  end
end
