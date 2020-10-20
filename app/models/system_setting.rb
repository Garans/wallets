# frozen_string_literal: true

class SystemSetting < ApplicationRecord
  validates :mfo, length: { minimum: 6, maximum: 6 }

  validates :check_iban_number, length: { minimum: 2, maximum: 2 },
                                format: { with: /\A\d+\z/, message: 'Integer only. No sign allowed.' }

  def prefix_iban
    country_short_code + check_iban_number.to_s + mfo.to_s
  end
end
