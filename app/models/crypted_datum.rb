# frozen_string_literal: true

class CryptedDatum < ApplicationRecord
  establish_connection DB_CRYPTED
  include Vault::EncryptedModel
  vault_attribute :value

  validate :instance_validations

  belongs_to :owner, polymorphic: true, optional: true

  private

  def instance_validations
    v = PinValidator.new
    v.pin = value
    v.record = self
    errors.add(:value, v.errors.full_messages) unless v.valid_pin_size?
  end

end
