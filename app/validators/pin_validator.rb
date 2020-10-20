# frozen_string_literal: true

class PinValidator
  include ActiveModel::Validations

  attr_accessor :pin, :record

  validate :validate_pin_size
  validate :validate_pin_for_wallet

  def validate_pin_size
    return if pin.to_s =~ /\A\d{4}\z/

    errors.add(:pin, 'code must be from 4 number elements')
  end

  def valid_pin_size?
    valid? :validate_pin_size
  end

  def validate_pin_for_wallet
    value = record.is_a?(CryptedDatum) ? record.value : CryptedDatum.find_by(owner: record).value
    return if value == pin

    errors.add(:pin, 'code incorrect')
  end
end
