# frozen_string_literal: true

class ScoreGenerator
  # Score generator using base Luna algorithms

  PREFIX_CARDS = {
    mastercard: { prefixes: %w[51 52 53 54 55], length: 15 },
    visa: { prefixes: %w[4], length: 16 }
  }.freeze

  CURRENCY_CARD_TYPE = { USD: :visa, EUR: :mastercard }.freeze

  attr_reader :position_start, :currency, :prefix_card_number, :card_number, :score

  def self.perform(currency, position_start = nil)
    new(currency, position_start).call
  end

  def initialize(currency, position_start = nil)
    @currency = currency
    @position_start = position_start
  end

  def call
    value = generate

    value = generate until credit_card_valid?(value)
    @score = value[prefix_card_number.count..value.count].join
    @card_number = value.join
  end

  def credit_card_valid?(card)
    check = card.pop

    sum = card.reverse.each_slice(2).flat_map do |x, y|
      [(x * 2).divmod(10), y || 0]
    end.flatten.inject(:+)

    check.zero? ? (sum % 10).zero? : (10 - sum % 10) == check
  end

  private

  def card_type
    return @card_type if @card_type.present?

    select_type = CURRENCY_CARD_TYPE[currency.id.to_sym]
    select_type = :mastercard if select_type.blank?

    @card_type = PREFIX_CARDS[select_type]
  end

  def prefill
    prefix = card_type[:prefixes].sample.split
    size = card_type[:length] - prefix.count
    { prefix_code: prefix.map(&:to_i), size: size }
  end

  def generate
    base_setting = prefill
    @prefix_card_number = base_setting[:prefix_code]
    prefix_card_number + (base_setting[:size] + 1).times.map { rand(0..9) }
  end
end
