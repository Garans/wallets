# frozen_string_literal: true

class CurrencyConverter < ApplicationRecord
  belongs_to :first_currency, class_name: 'Currency', foreign_key: 'first_currency_id'
  belongs_to :second_currency, class_name: 'Currency', foreign_key: 'second_currency_id'
end
