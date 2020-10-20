# frozen_string_literal: true

class CommissionRule < ApplicationRecord
  has_many :transactions

  enum commission_type: { fixed: 0, percent: 1 }

  def commission_amount(amount)
    percent? ? amount * rate : rate
  end

  class << self
    def build_commission_with_amount(amount)
      commission = select_commission(amount)

      return amount if commission.blank?

      commission_tax = commission.percent? ? amount * commission.rate : commission.rate
      amount + commission_tax
    end

    def select_commission(amount)
      CommissionRule.find_by(
        '(? between from_price and to_price) OR (from_price <= ? and to_price IS NULL)',
        amount, amount
      )
    end
  end
end
