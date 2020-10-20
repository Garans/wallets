class WalletAvailable < ApplicationRecord
  belongs_to :currency
  include Vault::EncryptedModel
  vault_attribute :number

  scope :available, -> { where(status: true) }

  class << self
    def take_available_score(currency)
      where(currency: currency).available.order('random()').limit(1)&.first
    end
  end
end
