# frozen_string_literal: true

class IbanNumberGenerator
  SCORE_SIZE = 18
  IBAN_SIZE = 29

  attr_reader :bank_setting, :score, :currency

  def self.perform(bank_setting, score, currency)
    new(bank_setting, score, currency).call
  end

  def initialize(bank_setting, score, currency)
    @bank_setting = bank_setting
    @score = score
    @currency = currency
  end

  def call
    iban_score = build_iban
    raise StandardError unless check_sum(iban_score)

    iban_score
  end

  def build_iban
    empty_space = '0' * (SCORE_SIZE - score.length)

    currency.id + bank_setting.check_iban_number.to_s + bank_setting.mfo.to_s + empty_space + score
  end

  def check_sum(iban_score)
    iban_score.length == IBAN_SIZE
  end
end
