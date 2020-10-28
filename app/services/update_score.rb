# frozen_string_literal: true

class UpdateScore
  attr_reader :wallet, :params, :validator

  def self.perform(wallet, params)
    new(wallet, params).call
  end

  def initialize(wallet, params)
    @wallet = wallet
    @params = params
    @validator = PinValidator.new
  end

  def call
    raise StandardError.new(validator.errors.full_messages.join(', ')) unless validates!

    wallet.class.transaction do
      wallet.description = params[:description]
      wallet.save!
      wallet.crypted_datum.update(value: params[:pin_new]) if params[:pin_new].present?
    end

    wallet
  end

  private

  def validates!
    validator.pin = params[:pin]
    validator.record = wallet
    validator.valid?
  end
end
