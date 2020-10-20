# frozen_string_literal: true

class Atm < ApplicationRecord
  include Vault::EncryptedModel
  vault_attribute :number
  belongs_to :currency

  has_many :transaction_send_infos, as: :sender
  has_many :transaction_send_infos, as: :recipient

  class << self
    def find_wallet_by_in_crypt(number)
      wallet = nil
      find_each.each do |record|
        next if record.number != number

        wallet = record
        break
      end
      wallet
    end
  end
end
