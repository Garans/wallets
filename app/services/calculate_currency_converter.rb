# frozen_string_literal: true

class CalculateCurrencyConverter
  def initialize(params)
    @config = params
  end

  def call(amount)
    config.course * amount
  end

  private

  def config
    @config.is_a?(Hash) ? CurrencyConverter.new(@config) : @config
  end
end
